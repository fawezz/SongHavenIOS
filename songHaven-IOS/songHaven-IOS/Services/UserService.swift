//
//  UserService.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 12/11/2022.
//
import Alamofire
import SwiftyJSON
import Foundation

class UserService{
    static let signInURL = "http://192.168.0.2:9090/user/signin"
    
    static func SignIn(email: String, password: String, completed: @escaping (Bool, Any?) -> Void){
        
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
            .validate(statusCode: 200..<300)
                        .validate(contentType: ["application/json"])
                        .responseData { response in
                            switch response.result {
                            case .success:
                                let jsonData = JSON(response.data!)
                                let currentUser = User.fromJson(jsonData: jsonData["currentUser"])
                                
                                UserDefaults.standard.setValue(
                                    jsonData["token"].stringValue,forKey: "token"
                                )
                                UserDefaults.standard.setValue(
                                    currentUser._id, forKey: "userId"
                                )
                                UserDefaults.standard.setValue(
                                    currentUser.email, forKey: "email"
                                )
                                print(currentUser)
                                
                                completed(true, currentUser)
                            case let .failure(error):
                                debugPrint(error)
                                completed(false, nil)
                            }
                        }
            /*.responseJSON { response in
                debugPrint(response)
            }*/
        
    }
    
    
}
