//
//  User.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 11/11/2022.
//

struct Utilisateur {
    
    internal init(_id: String? = nil, email: String? = nil, password: String? = nil, name: String? = nil, lastname: String? = nil, idPhoto: String? = nil, isVerified: Bool? = nil) {
        self._id = _id
        self.email = email
        self.mdp = password
        self.name = name
        self.lastname = lastname
        self.idPhoto = idPhoto
        self.isVerified = isVerified
    }
    
    var _id : String?
    var email : String?
    var mdp  : String?
    var name : String?
    var lastname : String?
    var idPhoto : String?
    var isVerified : Bool?
    
    // relations
}
