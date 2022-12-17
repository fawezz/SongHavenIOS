//
//  UserService.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 12/11/2022.
//
import Alamofire
import SwiftyJSON
import Foundation
import UIKit

class UserService{
    static let SignInURL = Constants.HOSTNAME + "/user/signin"
    static let SignUpURL = Constants.HOSTNAME + "/user/signup"
    static let ResendWelcomeMailURL = Constants.HOSTNAME + "/user/resendWelcomeMail"
    
    static let SendOtpMailURL = Constants.HOSTNAME + "/user/forgotPassword/sendOtpMail"
    static let VerifyOtpURL = Constants.HOSTNAME + "/user/forgotPassword/verifyOTP"
    static let CreatePasswordURL = Constants.HOSTNAME + "/user/forgotPassword/createNewPassword"
    static let EditDetailsURL = Constants.HOSTNAME + "/user/modifyDetails"
    
    static let UploadImageURL = Constants.HOSTNAME + "/user/profileImage"
    static let UserImageUrl = Constants.HOSTNAME + "/img/user/"
    static let searchUsersURL = Constants.HOSTNAME + "/user/searchByName"
    static let GetByIdURL = Constants.HOSTNAME + "/user/getById"
    static let LoginByEmailURL = Constants.HOSTNAME + "/user/loginByEmail"
    
    static func SignIn(email: String, password: String, completed: @escaping (Bool, Any?) -> Void){
        
        let headers : HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [
            "email" : email,
            "password" : password
        ]
        
        AF.request(SignInURL,  method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers )
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
                    UserDefaults.standard.setValue(
                        currentUser.imageId, forKey: "imageId"
                    )
                    UserDefaults.standard.setValue(
                        currentUser.lastname, forKey: "lastname"
                    )
                    UserDefaults.standard.setValue(
                        currentUser.firstname, forKey: "firstname"
                    )
                    print(currentUser)
                    
                    completed(true, currentUser)
                case let .failure(error):
                    if(response.response?.statusCode == 401){
                        completed(false, "Wrong Password")
                    }
                    
                    else{
                        completed(false, "Account not found")
                    }
                    debugPrint(error)
                    
                }
            }
    }
    
    static func SignUp(email: String, password: String, firstName: String, lastName: String, completed: @escaping (Bool, Any?, String?) -> Void){
        
        let headers : HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [
            "email" : email,
            "password" : password,
            "firstname" : firstName,
            "lastname" : lastName
        ]
        AF.request(SignUpURL,  method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let currentUser = User.fromJson(jsonData: jsonData["currentUser"])
                    let token = jsonData["token"].stringValue

                    print(currentUser)
                    completed(true, currentUser, token)
                case let .failure(error):
                    if(response.response?.statusCode == 409){
                        let jsonData = JSON(response.data!)
                        let message = jsonData["message"].stringValue
                        print( message)
                        completed(false, message, nil)
                    }else{
                        print("sign up service error" + error.errorDescription!)
                    }
                    
                    
                }
            }
    }
    
    static func SendOtpMail(email: String, completed: @escaping (Bool, String?) -> Void){
        
        let headers : HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [
            "email" : email,
        ]
        AF.request(SendOtpMailURL,  method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let message = jsonData["message"].stringValue
                    
                    print(message)
                    
                    completed(true, message)
                case let .failure(error):
                    if(response.response?.statusCode == 404){
                        let jsonData = JSON(response.data!)
                        let message = jsonData["message"].stringValue
                        print(message)
                        completed(false, message)
                    }else{
                        completed(false, error.errorDescription)
                    }
                    
                }
            }
    }
    static func ResendWelcomeMail(id: String, email: String, completed: @escaping (Bool, String?) -> Void){
        
        let headers : HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [
            "id" : id ,
            "email" : email,
        ]
        AF.request(ResendWelcomeMailURL,  method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let message = jsonData["message"].stringValue
                    print(message)
                    
                    completed(true, message)
                case let .failure(error):
                    if(response.response?.statusCode == 404){
                        let jsonData = JSON(response.data!)
                        let message = jsonData["message"].stringValue
                        print(message)
                        completed(false, message)
                    }else{
                        completed(false, error.errorDescription)
                    }
                }
            }
    }
    
    static func VerifyOtp(email: String, otpCode: String, completed: @escaping (Bool, Bool?) -> Void){
        
        let headers : HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [
            "email" : email,
            "otpCode" : otpCode
        ]
        AF.request(VerifyOtpURL,  method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let otpVerified = jsonData["otpVerified"].boolValue
                    
                    print("otp verified = " + otpVerified.description)
                    
                    completed(true, otpVerified)
                case .failure(_):
                    if(response.response?.statusCode == 401){
                        let jsonData = JSON(response.data!)
                        let otpVerified = jsonData["otpVerified"].boolValue
                        print("otp verified = " + otpVerified.description)
                        completed(true, otpVerified)
                    }else{
                        print("error happened")
                        completed(false, nil)
                    }
                }
            }
    }
    
    static func CreateNewPassword(email: String, password: String, completed: @escaping (Bool, String?) -> Void){
        
        let headers : HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [
            "email" : email,
            "password" : password
        ]
        AF.request(CreatePasswordURL,  method: .put, parameters: params, encoder: JSONParameterEncoder.default, headers: headers )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let message = jsonData["message"].stringValue
                    print(message)
                    completed(true, message)
                case .failure:
                    let jsonData = JSON(response.data!)
                    let message = jsonData["message"].stringValue
                    print(message)
                    completed(false, message)
                }
            }
    }
    
    static func EditDetails(id: String, firstname: String, lastname: String, password: String, completed: @escaping (Bool, Any?) -> Void){
        
        let headers : HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [
            "id" : id,
            "firstname" : firstname,
            "lastname" : lastname,
            "password" : password,
            //"imageId" : imageId,
        ]
        
        AF.request(EditDetailsURL,  method: .put, parameters: params, encoder: JSONParameterEncoder.default, headers: headers )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let currentUser = User.fromJson(jsonData: jsonData["currentUser"])
                    
                    UserDefaults.standard.setValue(
                        jsonData["firstname"].stringValue,forKey: "firstname"
                    )
                    UserDefaults.standard.setValue(
                        jsonData["lastname"].stringValue,forKey: "lastname"
                    )
                    UserDefaults.standard.setValue(
                        currentUser._id, forKey: "userId"
                    )
                    
                    print(currentUser)
                    
                    completed(true, currentUser)
                case let .failure(error):
                    debugPrint(error)
                    let jsonData = JSON(response.data!)
                    let message = jsonData["message"].stringValue
                    print(message)
                    completed(false, message)
                }
            }
    }
    
    static func uploadImage(email: String, image : UIImage?, completed: @escaping (Bool, String) -> Void){
        
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type": "multipart/form-data"
        ]
        let params = [
            "email" : email,
        ]
        
        AF.upload(
            multipartFormData: { multipartFormData in
                for(key, keyValue) in params{
                    if let keyData = keyValue.data(using: .utf8){
                        multipartFormData.append(keyData, withName: key)
                    }
                }
                multipartFormData.append(image!.jpegData(compressionQuality: 0)!, withName: "image" , fileName: "file.jpeg", mimeType: "image/jpeg")
            },
            to: UserService.UploadImageURL, method: .post, headers: headers)
        .response { response in
            switch response.result {
            case .success:
                let jsonData = JSON(response.data!)
                let imageId = jsonData["imageId"].stringValue
                let message = jsonData["message"].stringValue
                
                UserDefaults.standard.setValue(
                    imageId,forKey: "imageId"
                )
                print("success")
                completed(true, message)
                
            case let .failure(error):
                debugPrint(error)
                let jsonData = JSON(response.data!)
                let message = jsonData["message"].stringValue
                print(message)
                completed(false, message)
            }
            
        }
    }
    
    static func SearchUsers( searchText: String, completed: @escaping (Bool, [User]) -> Void){
        
        let headers : HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [
            
            "searchText" : searchText
        ]
        AF.request(searchUsersURL,  method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    var users : [User] = []
                    for singleJsonItem in jsonData["users"] {
                        users.append(User.fromJson(jsonData: singleJsonItem.1))
                    }
                    print("success search Users")
                    completed(true, users)
                case let .failure(error):
                    print(error.errorDescription)
                    completed(false, [])
                    debugPrint(error)
                }
            }
    }
    
    static func GetById(userId: String, completed: @escaping (Bool, User?) -> Void){
        let headers : HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        
        let params = [
            "userId" : userId,
        ]
        AF.request(GetByIdURL,  method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let user = User.fromJson(jsonData: jsonData["user"])
                    completed(true, user)
                case let .failure(error):
                    if(response.response?.statusCode == 409){
                        completed(false, nil)
                        print(error.errorDescription!)
                    }
                }
            }
    }
    
   static func loginByEmail(email: String, completed: @escaping (Bool, User?) -> Void) {
        AF.request(UserService.LoginByEmailURL,
                          method: .post,
                          parameters: ["email": email])
                   .validate(statusCode: 200..<300)
                   .validate(contentType: ["application/json"])
                   .responseData { response in
                       switch response.result {
                       case .success:
                           let jsonData = JSON(response.data!)
                           
                           UserDefaults.standard.setValue(jsonData["token"].stringValue, forKey: "token")
                           UserDefaults.standard.setValue(jsonData["userId"].stringValue, forKey: "userId")
                           let currentUser : User = User.fromJson(jsonData: jsonData["currentUser"])
                           completed(true, currentUser)
                       case let .failure(error):
                           debugPrint(error)
                           completed(false, nil)
                       }
                   }
           }
}


