//
//  User.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 11/11/2022.
//
import SwiftyJSON
struct User : Decodable{
    
    internal init(_id: String? = nil, email: String? = nil, password: String? = nil, firstname: String? = nil, lastname: String? = nil, imageId: String? = nil, isVerified: Bool? = nil) {
        self._id = _id
        self.email = email
        self.password = password
        self.firstname = firstname
        self.lastname = lastname
        self.imageId = imageId
        self.isVerified = isVerified
    }
    
    var _id : String?
    var email : String?
    var password  : String?
    var firstname : String?
    var lastname : String?
    var imageId : String?
    var isVerified : Bool?
    
    // relations
    
    static func fromJson(jsonData: JSON) -> User {
            
            var BParray : [String] = []
            for singleJsonItem in jsonData["blockedPosts"]   {
                BParray.append(singleJsonItem.1.stringValue)
            }
            
            var BUarray : [String] = []
            for singleJsonItem in  jsonData["blockedUsers"]  {
                BUarray.append(singleJsonItem.1.stringValue)
            }
            
            return User(
                _id: jsonData["_id"].stringValue,
                email: jsonData["email"].stringValue,
                //password: jsonItem["mdp"].stringValue,
                firstname: jsonData["firstname"].stringValue,
                lastname: jsonData["lastname"].stringValue,
                imageId: jsonData["imageId"].stringValue,
                isVerified: jsonData["isVerified"].boolValue
            )
        }
    
    func getFullName() -> String {
        return self.firstname!.capitalized + " " + self.lastname!.capitalized
    }
}
