//
//  SocketChatManager.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 12/12/2022.
//

import Foundation
import SocketIO
import Combine
import SwiftyJSON

class SocketChatManager : ObservableObject {
    var manager = SocketManager(socketURL: URL(string: Constants.HOSTNAME)! ,config: [.log(false), .reconnects(true)])
    var socket: SocketIOClient
    @Published var messageStream : PassthroughSubject<TextMessage, Never>
    @Published var userBands = [Band]()
    
    static let shared: SocketChatManager = {
        let instance = SocketChatManager()
        return instance
    }()
    internal init() {
        messageStream = PassthroughSubject<TextMessage, Never>()
        socket = manager.defaultSocket
        socket.connect()
        fetchUserBands()
    }
    
    func setupSocketEvents() {
        socket.on(clientEvent: .connect) {data, ack in
            print("Connected")
            for band in self.userBands{
                let data: [String: String] = [
                    "userId" : (UserSession.shared.currentUser?._id)!,
                    "roomId" : band._id!
                ]
                self.socket.emit("join_room", data)
            }
        }
        
        socket.on("bot_message") { (data, ack) in
            print("Message received" + data.description)
        }
        
        socket.on("receive_message") { (data, ack) in
            let serializedData = try? JSONSerialization.data(withJSONObject: data)
            if(serializedData != nil){
                let json = try! JSON(data: serializedData!)
                //print("json :" + json.description)
                let newMessage : TextMessage? = TextMessage.fromJson(jsonData: json[0])
                if (newMessage != nil) {
                    SocketChatManager.shared.messageStream.send(newMessage!)
                    if(newMessage?.sender._id != UserSession.shared.currentUser?._id){
                        let title = "New Message received"
                        let body = (newMessage?.sender.getFullName())! + ": " + newMessage!.text
                        NotificationService.showMessageNotification(title: title, body: body)
                    }
                    print("message received = " + newMessage!.text)

                }else{
                    print("error parsing the received message")
                }
            }else{
                print("error parsing received data")
            }
            
        }
        
    }
    func sendMessage(textMessage: TextMessage, roomId: String) {
        let data: [String: String] = [
            "senderId" : textMessage.sender._id!, //(UserSession.shared.currentUser?._id)!,
            "conversationId" : textMessage.conversationId,
            "text" : textMessage.text,
            "roomId" : roomId
        ]
        self.socket.emit("send_message", data)
    }
    
    private func fetchUserBands() {
        BandService.getByUser( completed: { (success, bandArray) in
            if(success){
                self.userBands = bandArray ?? []
            }
        })
    }
}






//            socket?.on("typing") { (data, ack) in
//                guard let dataInfo = data.first else { return }
//                if let response: SocketUserTyping = try? SocketParser.convert(data: dataInfo) {
//                    print("User \(response.username) is typing...")
//                }
//            }
//
//            socket?.on("stop typing") { (data, ack) in
//                guard let dataInfo = data.first else { return }
//                if let response: SocketUserTyping = try? SocketParser.convert(data: dataInfo) {
//                    print("User \(response.username) stopped typing...")
//                }
//            }
