//
//  BandService.swift
//  songHaven-IOS
//  Created by SongH on 26/11/2022.
//

import Alamofire
import SwiftyJSON
import Foundation
import UIKit
class BandService{
    static let CreateBandURL = ""
    static let DeleteBandURL = ""
    static func createBand(id : String, name: String, discription: String, completed: @escaping (Bool, Any?) ->Void){
        
        let headers :HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [
            
            "id" : id,
            "name" : name ,
            "discription" : discription,
        ]
        AF.request(CreateBandURL, method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers )
            .validate(statusCode : 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let currentBand = Band.fromJson(jsonData: jsonData["currentBand"])
                    print(currentBand)
                    completed(true, currentBand)
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
    
    static func supprimerBand( _id : String?, completed: @escaping (Bool, Any?) ->Void){
        
        let headers :HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [  "_id" : _id ]
        
        AF.request(DeleteBandURL, method: .delete, parameters: params, encoder: JSONParameterEncoder.default, headers: headers )
            .validate(statusCode : 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    completed(true)+
                    
                case let .failure (error)
                    debugPrint(error)
                    completed(false)
                }
            }
        
    }
}
