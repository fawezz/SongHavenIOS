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
    static let  ip = "http://172.17.2.137:9090"
    static let UploadImageURL = ""
    static let CreateBandURL = "http://172.17.2.137:9090/band/CreateBand"
    static let DeleteBandURL = "http://172.17.2.78:9090/band/delete"
    static let EditBandURL = "http://172.17.2.78:9090/band/modify"
    static let getAllURL = "http://172.17.2.78:9090/band/getAllBand"
    static let getByUserURL = "http://172.17.2.78:9090/band/getByUser"
    static let AddMumberURL = "http://172.17.2.137:9090/band/addArtiste"
    static let BandImageUrl = "http://172.17.2.137:9090/img/"
    
    static func create(/*creator: User,*/name: String, discription: String,imageId: String, completed: @escaping (Bool, Any?) ->Void){
        
        let headers :HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [
           // "creatorId": creator._id!,
            "name" : name ,
            "discription" : discription,
            "imageId" : imageId
        ]
        AF.request(CreateBandURL, method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers )
            .validate(statusCode : 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
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
    
    static func supprimerBand( id : String?, completed: @escaping (Bool, Any?) ->Void){
        
        let headers :HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [ "id" : id ]
        
        AF.request(DeleteBandURL, method: .delete, parameters: params, encoder: JSONParameterEncoder.default, headers: headers )
            .validate(statusCode : 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let message = jsonData["message"].stringValue
                    print(message)
                    completed(true, message)
                case let  .failure(error):
                    completed(false, error.errorDescription)
                    debugPrint(error)
                }
            }
        
    }
    
    static func EditBand(id: String,name: String, discription: String, completed:
        @escaping (Bool, Any?) ->Void){
        
        let headers :HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [
            "id": id,
            "name" : name ,
            "discription" : discription,
        ]
        AF.request(EditBandURL, method: .put, parameters: params, encoder: JSONParameterEncoder.default, headers: headers )
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
    
    
    static func uploadImage(name: String, image : UIImage?, completed: @escaping (Bool, String) -> Void){
        
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
        let params = [
            "name" : name,
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
            to: BandService.UploadImageURL, method: .post, headers: headers)
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
                let jsonData = JSON(response.data ?? "data")
                let message = jsonData["message"].stringValue
                print(message)
                completed(false, message)
            }
            
        }
    }
    
    static func GetAllBands( completed:@escaping (Bool, [ Band]?) ->Void){
        AF.request(getAllURL,method: .get)
            .validate(statusCode : 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    var bands : [ Band]? = []
                    for singleJsonItem in jsonData [ "bands "]{
                            bands!.append( Band.fromJson(jsonData: singleJsonItem.1))}
                        print("success get All Bands")
                        completed ( true, bands)
                
                case let .failure(error):
                    if(response.response?.statusCode == 409){
                        let jsonData = JSON(response.data!)
                        let message = jsonData["message"].stringValue
                        print( message)
                        completed(false, [ ])
                    }else{
                        print("Error" + error.errorDescription!)
                    }
                    
                    
                }
            }
        
    }
    
    static func GetByUser( creatorId: String ,completed:@escaping (Bool, [ Band]?) ->Void){
        AF.request(getByUserURL + ""/* creatorId*/,method: .get)
            .validate(statusCode : 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    var bands : [ Band]? = []
                    for singleJsonItem in jsonData [ "bands "]{
                            bands!.append( Band.fromJson(jsonData: singleJsonItem.1))}
                        print("success get All Bands")
                        completed ( true, bands)
                
                case let .failure(error):
                    if(response.response?.statusCode == 409){
                        let jsonData = JSON(response.data!)
                        let message = jsonData["message"].stringValue
                        print( message)
                        completed(false, [ ])
                    }else{
                        print("Error" + error.errorDescription!)
                    }
                    
                    
                }
            }
        
    }
    
    
}
