//
//  Invitation.swift
//  songHaven-IOS
//
//  Created by SongH on 13/12/2022.
//

import SwiftyJSON
struct Invitation : Equatable{
 
    
    
    internal init(_id: String? = nil, requester: Band? = nil ,recipient: User? = nil, status : Status) {
        self._id = _id
        self.requester = requester
        self.recipient = recipient
        self.status = status
    }
    
    var _id : String?
    var requester : Band?
    var recipient : User?
    var status : Status
    
    
    static func fromJson(jsonData: JSON) -> Invitation {
        return Invitation(
            _id: jsonData["_id"].stringValue,
            requester : Band.fromJson(jsonData: jsonData["requester"]),
            recipient : User.fromJson(jsonData: jsonData["recipient"]),
            status: Status(rawValue: jsonData[ "status"].intValue)!
    
        
        )
           }

    static func == (lhs: Invitation, rhs: Invitation) -> Bool {
        return lhs._id == rhs._id
    }
}

