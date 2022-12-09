//
//  LikeService.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 3/12/2022.
//

import Foundation
import SwiftyJSON
import Alamofire
class LikeService{
    static let toggleLikeURL = Constants.HOSTNAME + "/like/toggle"
    static let artistTotalLikesURL = Constants.HOSTNAME + "/like/artistTotalLikes/"
    static let isLikedByUserURL = Constants.HOSTNAME + "/like/isLikedByUser"
    
    
    
    static func isLikedByUser(songId: String, completed: @escaping (Bool, Bool?) -> Void){
        
        let headers : HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [
            "songId" : songId,
            "userId" : UserDefaults.standard.string(forKey: "userId")!
        ]
        AF.request(isLikedByUserURL,  method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers  )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let isLiked : Bool = jsonData["liked"].boolValue
                    print("song is liked: " + isLiked.description)
                    completed(true, isLiked)
                case let .failure(error):
                    debugPrint(error.errorDescription!)
                    completed(false, nil)
                }
            }
    }
    
    static func toggleLike(songId: String, completed: @escaping (Bool, Bool?) -> Void){
        
        let headers : HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [
            "songId" : songId,
            "userId" : UserDefaults.standard.string(forKey: "userId")!
        ]
        
        AF.request(toggleLikeURL,  method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers  )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let isLiked : Bool = jsonData["liked"].boolValue
                    print("song is liked: " + isLiked.description)
                    completed(true, isLiked)
                case let .failure(error):
                    debugPrint(error.errorDescription!)
                    completed(false, nil)
                }
            }
    }
    
    static func getArtistTotalLikes(completed: @escaping (Bool, Int) -> Void){
        let userId : String = UserDefaults.standard.string(forKey: "userId")!
        AF.request(artistTotalLikesURL + userId,  method: .get ) //"63749eac6781be3df2521807"
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let total = jsonData["totalLikes"].intValue
                    print("TOTAAAAL" + total.description)
                    completed(true, total)
                case let .failure(error):
                    print(error)
                    completed(false, 0)
                    debugPrint(error)
                }
            }
    }
}
