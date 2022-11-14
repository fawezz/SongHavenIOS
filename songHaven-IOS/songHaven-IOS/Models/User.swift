//
//  User.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 11/11/2022.
//
import SwiftyJSON
struct User : Decodable{
    
    internal init(_id: String? = nil, email: String? = nil, password: String? = nil, firstname: String? = nil, lastname: String? = nil, idPhoto: String? = nil, isVerified: Bool? = nil) {
        self._id = _id
        self.email = email
        self.password = password
        self.firstname = firstname
        self.lastname = lastname
        self.idPhoto = idPhoto
        self.isVerified = isVerified
    }
    
    var _id : String?
    var email : String?
    var password  : String?
    var firstname : String?
    var lastname : String?
    var idPhoto : String?
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
                /*dateNaissance: DateUtils.formatFromString(string: jsonItem["dateNaissance"].stringValue),*/
                idPhoto: jsonData["idPhoto"].stringValue,
                isVerified: jsonData["isVerified"].boolValue
            )
        }
}
