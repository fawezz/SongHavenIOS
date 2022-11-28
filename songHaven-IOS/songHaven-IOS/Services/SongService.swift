//
//  SongService.swift
//  songHaven-IOS
//
//  Created by zewaff on 26/11/2022.
//
import Alamofire
import SwiftyJSON
import Foundation
import UIKit

class SongService{
    let ip = "http://192.168.0.3:9090"
    static let getAllURL = "http://192.168.0.3:9090/song/getAll"
    static let getByUserURL = "http://192.168.0.3:9090/song/getByUser/"
    static let createURL = "http://192.168.0.3:9090/song/create"
    static let modifyeURL = "http://192.168.0.3:9090/song/modify"
    static let deleteSongURL = "http://192.168.0.3:9090/song/delete/"
    static let songImageUrl = "http://192.168.0.3:9090/img/"
    static let songMusicUrl = "http://192.168.0.3:9090/music/" + "music1669159393115.mp3"
    
    static func GetAllSongs(completed: @escaping (Bool, [Song]?) -> Void){
        AF.request(getAllURL,  method: .get )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    var songs : [Song]? = []
                    for singleJsonItem in jsonData["songs"] {
                        songs!.append(Song.fromJson(jsonData: singleJsonItem.1))
                    }
                    print("success get All Songs")
                    completed(true, songs)
                case let .failure(error):
                    print(error)
                    completed(false, [])
                    debugPrint(error)
                    
                }
            }
    }
    
    static func GetByUser(creatorId: String, completed: @escaping (Bool, [Song]?) -> Void){
        AF.request(getByUserURL + "63749eac6781be3df2521807"/*creatorId*/,  method: .get )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    var songs : [Song]? = []
                    for singleJsonItem in jsonData["songs"] {
                        songs!.append(Song.fromJson(jsonData: singleJsonItem.1))
                    }
                    print("success received Songs: " + (songs?.count.description)!)
                    completed(true, songs)
                case let .failure(error):
                    print(error)
                    completed(false, [])
                    debugPrint(error)
                    
                }
            }
    }
    static func DeleteSong(songId: String, completed: @escaping (Bool, String?) -> Void){
        AF.request(deleteSongURL + "637d586fe95ad20baf9a47e0"/*songId*/,  method: .delete )
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
    
}
