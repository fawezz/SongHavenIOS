//
//  SocketChatManager.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 12/12/2022.
//

import Foundation
import SocketIO

class SocketChatManager : ObservableObject {
    let manager = SocketManager(socketURL: URL(string: "http://172.17.12.84:9090")! ,config: [.log(false), .reconnects(true)])
    var socket: SocketIOClient?
    
    init() {
        let socket = manager.defaultSocket
        socket.connect()
        socket.on(clientEvent: .connect) {[self]data, ack in
            print("socket connected")
        }
    }
    
//    func stop() {
//        socket?.removeAllHandlers()
//    }
    
    func setupSocketEvents() {
        socket?.on(clientEvent: .connect) {data, ack in
                print("Connected")
            }

            socket?.on("bot_message") { (data, ack) in
                guard let dataInfo = data.first else { return }
                    print("Message received")
                
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
        }

    
    
}
