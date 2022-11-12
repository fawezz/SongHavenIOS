//
//  UserService.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 12/11/2022.
//
import Alamofire
class UserService{
    static let signInURL = "http://172.17.1.82:9090/user/signin"
    
    static func SignIn(email: String, password: String){
        
        //"Authorization":"token"
        let headers : HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [
            "email" : email,
            "password" : password
        ]
        
        AF.request(signInURL,  method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers )
            .responseJSON { response in
                debugPrint(response)
            }
        
    }
}
