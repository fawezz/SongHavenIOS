//
//  Message.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 9/12/2022.
//

import Foundation
import SwiftyJSON
struct TextMessage : Identifiable,Decodable{
    
    internal init(id: String, text: String ,sender: User, timestamp: Date?, conversationId: String ) {
        self.id = id
        self.text = text
        self.sender = sender
        self.timestamp = timestamp
        self.conversationId = conversationId
    }
    
    var id : String
    var text : String
    var sender : User
    var timestamp : Date?
    var conversationId: String
    
    static func fromJson(jsonData: JSON) -> TextMessage {
         let sender = User.fromJson(jsonData: jsonData["sender"])
        return TextMessage(
            id: jsonData["_id"].stringValue,
            text: jsonData["text"].stringValue,
            sender: sender,
            timestamp: nil,
            conversationId: jsonData["conversation"].stringValue
            //timestamp : jsonData["timestamp"]
        )
    }
    
}
