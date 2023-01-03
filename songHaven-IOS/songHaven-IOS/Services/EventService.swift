//
//  EventService.swift
//  songHaven-IOS
//
//  Created by SongH on 21/12/2022.
//

import Alamofire
import SwiftyJSON
import Foundation
import UIKit

class EventService {
    
    static let AddEventURL = Constants.HOSTNAME + "/event/addEvent"
    static let EditEventURL = Constants.HOSTNAME + "/event/modify/"
    static let RemoveEventURL = Constants.HOSTNAME + "/event/deleteEvent/"
    static let getBandEventURL = Constants.HOSTNAME + "/event/getByCreator/"
    
//    static func AddEvent(event : Event , completed:@escaping(Bool,Int)->Void){
//        let token = UserDefaults.standard.string(forKey: "token")
//        let headers : HTTPHeaders = [.authorization(bearerToken: token ?? "cyrine"),.contentType("multipart/form-data")]
//        AF.upload(
//            multipartFormData: { multipartFormData in
//                multipartFormData.append((UserSession.shared.currentUser?._id!.data(using: String.Encoding.utf8)!)!, withName: "creatorId")
//                multipartFormData.append(event.title!.data(using: String.Encoding.utf8)!, withName: "title")
//                multipartFormData.append(event.description!.data(using: String.Encoding.utf8)!, withName: "description")
//                
//      
//                 multipartFormData.append(event.dateEvent!.data(using:Date.utf8)!, withName: "dateEvent")
//                multipartFormData.append(event.longitud!.data(using: String.Encoding.utf8)!, withName: "longitud")
//                multipartFormData.append(event.latitud!.data(using: String.Encoding.utf8)!, withName: "latitud")
//                
//            },to: AddEventURL,method: .post, headers: headers)
//        .validate(statusCode: 200..<300)
//        .responseData { response in
//            switch(response.result){
//                
//            case .success(let data):
//                print(data)
//                completed(true,200)
//            case .failure(let error):
//                print(error)
//                completed(false,error.responseCode!)
//            }
//            
//        }
//    }
    
    
    static func add(title: String, description: String,longitud: String,  latitud:String, dateEvent: Date, completed:
         @escaping (Bool, Any?) ->Void){
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let headers :HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [
  
            "title" : title,
            "description" : description ,
            "dateEvent" : dateFormatter.string(from : dateEvent),
            "longitud"  : longitud,
            "latitud"  : latitud ,
            
            
        ]
        AF.request(AddEventURL, method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers )
            .validate(statusCode : 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success( let JSON):
                    print("succe\(JSON)")
            
                case .failure( let JSON):
                    print("failure\(JSON)")
                }
            }
    }
    
    static func DeleteEvent(eventId: String, completed: @escaping (Bool, String?) -> Void){
        AF.request(RemoveEventURL + eventId,  method: .delete )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let message = jsonData["message"].stringValue
                    completed(true, message)
                case let .failure(error):
                    completed(false, error.errorDescription)
                    debugPrint(error)
                }
            }
    }
    
    
    static func EditEvent(id: String,title: String, description: String,longitud: String,  latitud:String ,completed:
                          @escaping (Bool, Any?) ->Void){
        
        let headers :HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [
            "id": id,
            "title" : title,
            "description" : description ,
        ]
        AF.request(EditEventURL, method: .put, parameters: params, encoder: JSONParameterEncoder.default, headers: headers )
            .validate(statusCode : 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let message = jsonData[ "message"].stringValue
                    print(message)
                    
                case let .failure(error):
                    if(response.response?.statusCode == 409){
                        let jsonData = JSON(response.data!)
                        let message = jsonData["message"].stringValue
                        print( message)
                        completed(false, message)
                    }else{
                        print("Error" + error.errorDescription!)
                    }
                    
                    
                }
            }
    }
    
    static func getEventByOwner(completed: @escaping (Bool, [Event]?) -> Void){
        let userId : String = UserDefaults.standard.string(forKey: "userId")!
        AF.request(getBandEventURL + userId,  method: .get )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    var events : [Event]? = []
                    for singleJsonItem in jsonData["events"] {
                        events!.append(Event.fromJson(jsonData: singleJsonItem.1))
                    }
                    print("success received events")
                    completed(true, events)
                case let .failure(error):
                    print(error)
                    completed(false, [])
                    debugPrint(error)
                    
                }
            }
    }
}
