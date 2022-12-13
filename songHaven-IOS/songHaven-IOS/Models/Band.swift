//
//  Band.swift
//  songHaven-IOS
//
//  Created by SongH on 26/11/2022.
//
import SwiftyJSON
struct Band : Decodable{
    
    internal init(_id: String? = nil, name: String? = nil, nbrOfMembers: Int? = nil, discription: String? = nil, image: String? = nil,users: [User]? = nil, creator : User? = nil) {
        self._id = _id
        self.name = name
        self.nbrOfMembers = nbrOfMembers
        self.discription  = discription
        self.image = image
        self.users = users
        self.creator = creator
        
    }
    
    var _id : String?
    var name : String?
    var nbrOfMembers : Int?
    var discription : String?
    var image : String?
    var creator : User?
    var users : [User]?
    
    
    static func fromJson(jsonData: JSON) -> Band {
        var users : [User]? = []
        for singleJsonItem in jsonData["users"] {
            users!.append(User.fromJson(jsonData: singleJsonItem.1))
        }
            return Band(
                _id: jsonData["_id"].stringValue,
                name: jsonData["name"].stringValue,
                nbrOfMembers: jsonData["nbrOfMembers"].intValue,
                discription: jsonData["discription"].stringValue,
                image: jsonData["image"].stringValue,
                users: users,
                creator : User.fromJson(jsonData: jsonData["creator"])
                
            )  }
}
