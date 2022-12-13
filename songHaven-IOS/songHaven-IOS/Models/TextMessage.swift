//
//  Message.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 9/12/2022.
//

import Foundation
import SwiftyJSON
struct TextMessage : Identifiable,Decodable{
    
    internal init(id: String, text: String ,sender: User, timestamp: Date? ) {
        self.id = id
        self.text = text
        self.sender = sender
        self.timestamp = timestamp
    }
    
    var id : String
    var text : String
    var sender : User
    var timestamp : Date?
    
    
    static func fromJson(jsonData: JSON) -> TextMessage {
         let sender = User.fromJson(jsonData: jsonData["sender"])
        return TextMessage(
            id: jsonData["id"].stringValue,
            text: jsonData["text"].stringValue,
            sender: sender,
            timestamp: nil
            //timestamp : jsonData["timestamp"]
        )
    }
    
}
