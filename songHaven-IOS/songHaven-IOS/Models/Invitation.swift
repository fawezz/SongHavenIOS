//
//  Invitation.swift
//  songHaven-IOS
//
//  Created by SongH on 13/12/2022.
//

import SwiftyJSON
struct Invitation :  Equatable{
    
    internal init(_id: String? = nil, requester: String? = nil ,recipient: String? = nil, status : Status) {
        self._id = _id
        self.requester = requester
        self.recipient = recipient
        self.status = status
    }
    
    var _id : String?
    var requester : String?
    var recipient : String?
    var status : Status
    
    
    static func fromJson(jsonData: JSON) -> Invitation {
        return Invitation(
            _id: jsonData["_id"].stringValue,
      
            requester : jsonData["requester"].stringValue,
            recipient : jsonData["recipient"].stringValue,
            status: Status(rawValue: jsonData[ "status"].intValue)!
    
        
        )
           }

    
}

