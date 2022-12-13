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
    static let UploadImageURL = ""
    static let CreateBandURL = Constants.HOSTNAME + "/band/CreateBand"
    static let DeleteBandURL = Constants.HOSTNAME + "/band/delete/"
    static let EditBandURL = Constants.HOSTNAME + "/band/modify/"
    static let getAllURL = Constants.HOSTNAME + "/band/getAllBand"
    static let getByUserURL = Constants.HOSTNAME + "/band/getByUser/"
    static let  addUserURL = Constants.HOSTNAME + "/band/addArtiste"
    static let BandImageUrl = Constants.HOSTNAME + "/img/band/"
    static let removeAertistURL = Constants.HOSTNAME + ""
    
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
    
    static func DeleteBand(bandId: String, completed: @escaping (Bool, String) -> Void){
            AF.request(DeleteBandURL + bandId,  method: .delete )
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    switch response.result {
                    case .success:
                        let jsonData = JSON(response.data!)
                        let message = jsonData["message"].stringValue
                        completed(true, message)
                    case let .failure(error):
                        completed(false, "error")
                        debugPrint(error)
                    }
                }
        }

    
    static func EditBand(id: String,name: String, discription: String,image: String, completed:
        @escaping (Bool, Any?) ->Void){
        
        let headers :HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [
            "id": id,
            "image" : image,
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
    
    
    static func add(band : Band , image :UIImage , completed:@escaping(Bool,Int)->Void){
            let token = UserDefaults.standard.string(forKey: "token")
        let headers : HTTPHeaders = [.authorization(bearerToken: token ?? "cyrine"),.contentType("multipart/form-data")]
            AF.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(image.jpegData(compressionQuality: 0.5)!, withName: "image",fileName: "band.jpg",mimeType: "image/jpg")
                    multipartFormData.append(band.name!.data(using: String.Encoding.utf8)!, withName: "name")
                    multipartFormData.append(band.discription!.data(using: String.Encoding.utf8)!, withName: "discription")
               
                },to: CreateBandURL,method: .post, headers: headers)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch(response.result){
                    
                case .success(let data):
                    print(data)
                    completed(true,200)
                case .failure(let error):
                    print(error)
                    completed(false,error.responseCode!)
                }
          
            }
    }

    
    static func getByUser(completed: @escaping (Bool, [Band]?) -> Void){
        let userId : String = UserDefaults.standard.string(forKey: "userId")!
        AF.request(getByUserURL + userId,  method: .get )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    var bands : [Band]? = []
                    for singleJsonItem in jsonData["bands"] {
                        bands!.append(Band.fromJson(jsonData: singleJsonItem.1))
                    }
                    print("aaaaaaaaaaa" + BandService.BandImageUrl + (bands?.first?.image)!)
                    print("success received Bands: " + (bands?.description)!)
                    completed(true, bands)
                case let .failure(error):
                    print(error)
                    completed(false, [])
                    debugPrint(error)
                    
                }
            }
    }
    static func AddUser( userId: String, completed: @escaping (Bool, Band?) -> Void){
            
            let headers : HTTPHeaders = [
                .contentType("application/json"),
                .accept("application/json")
            ]
            let params = [
              //  "bandId" : bandId,
                "userId" : userId
            ]
            
            AF.request(addUserURL,  method: .put, parameters: params, encoder: JSONParameterEncoder.default, headers: headers  )
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    switch response.result {
                    case .success:
                        let jsonData = JSON(response.data!)
                        let band = Band.fromJson(jsonData: jsonData["band"])
                        print("success added user to: " + band.name!)
                        completed(true, band)
                    case let .failure(error):
                        debugPrint(error.errorDescription!)
                        completed(false, nil)
                        
                        
                    }
                }
        }
    static func RemoveArtist(userId: String, completed: @escaping (Bool, Band?) -> Void){
        
        let headers : HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [
           // "bandId" : bandId,
            "userId" : userId
        ]
        
        AF.request(removeAertistURL,  method: .put, parameters: params, encoder: JSONParameterEncoder.default, headers: headers  )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let band = Band.fromJson(jsonData: jsonData["newBand"])
                    print("success removed Artist from: " + band.name!)
                    completed(true, band)
                case let .failure(error):
                    debugPrint(error.errorDescription!)
                    completed(false, nil)
                }
            }
    }
}
