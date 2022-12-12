//
//  SocketChatManager.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 12/12/2022.
//

import Foundation
import SocketIO

class SocketChatManager {
    let manager = SocketManager(socketURL: URL(string: "ws://172.17.4.48:3000")! ,config: [.log(false), .compress])
    var socket: SocketIOClient?
    
    init() {
        manager.connect()
        self.socket = manager.defaultSocket
        setupSocketEvents()
        socket?.connect()
        
        print(manager.socketURL)
        
    }
    
    func stop() {
        socket?.removeAllHandlers()
    }
    
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
