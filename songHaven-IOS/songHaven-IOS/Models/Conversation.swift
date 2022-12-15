//
//  Conversation.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 13/12/2022.
//

import Foundation
import SwiftyJSON
struct Conversation : Decodable{
    
    internal init(_id: String? = nil, band: Band? = nil,messages: [TextMessage]? = nil) {
        self._id = _id
        self.band = band
        if(messages == nil)
        {
            self.messages = [TextMessage]()
        }else{
            self.messages = messages!
        }
    }
    
    var _id : String?
    var band : Band?
    var messages : [TextMessage]
        
    static func fromJson(jsonData: JSON) -> Conversation {
        var textMessages : [TextMessage] = [TextMessage]()
        for singleJsonItem in jsonData["textMessages"] {
            textMessages.append(TextMessage.fromJson(jsonData: singleJsonItem.1))
        }

        return Conversation(
            _id: jsonData["_id"].stringValue,
            band: Band.fromJson(jsonData: jsonData["band"]),
            messages: textMessages
        )
    }
    
}
