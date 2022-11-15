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
    let ip = "http://172.17.1.89:9090"
    static let SignInURL = "http://172.17.1.89:9090/user/signin"
    static let SignUpURL = "http://172.17.1.89:9090/user/signup"
    static let ResendWelcomeMailURL = "http://172.17.1.89:9090/user/resendWelcomeMail"
    
    static let SendOtpMailURL = "http://172.17.1.89:9090/user/forgotPassword/sendOtpMail"
    static let VerifyOtpURL = "http://172.17.1.89:9090/user/forgotPassword/verifyOTP"
    static let CreatePasswordURL = "http://172.17.1.89:9090/user/forgotPassword/createNewPassword"
    static let EditDetailsURL = "http://172.17.1.89:9090/user/modifyDetails"
    
    
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
    
    static func SignUp(email: String, password: String, firstName: String, lastName: String, completed: @escaping (Bool, Any?) -> Void){
        
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
                    print(currentUser)
                    completed(true, currentUser)
                case let .failure(error):
                    if(response.response?.statusCode == 409){
                        let jsonData = JSON(response.data!)
                        let message = jsonData["message"].stringValue
                        print( message)
                        completed(false, message)
                    }else{
                        print("qqqqqqqqqq" + error.errorDescription!)
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
                    let jsonData = JSON(response.data!)
                    let message = jsonData["message"].stringValue
                    print(message)
                    completed(false, message)
                }
            }
    }
}
