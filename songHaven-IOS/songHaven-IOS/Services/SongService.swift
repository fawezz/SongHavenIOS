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
    static let getAllURL = Constants.HOSTNAME + "/song/getAll"
    static let getByUserURL = Constants.HOSTNAME + "/song/getByUser/"
    static let createURL = Constants.HOSTNAME + "/song/create"
    static let modifyeURL = Constants.HOSTNAME + "/song/modify"
    static let deleteSongURL = Constants.HOSTNAME + "/song/delete/"
    static let songImageUrl = Constants.HOSTNAME + "/img/"
    static let songMusicUrl = Constants.HOSTNAME + "/music/" //+ "music1669159393115.mp3"
    static let searchSongsURL = Constants.HOSTNAME + "/song/search"
    
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
    
    
    static func SearchSongs(criteria: String, searchText: String, completed: @escaping (Bool, [Song]) -> Void){
        
        let headers : HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [
            "criteria" : criteria,
            "searchText" : searchText
        ]
        
        AF.request(searchSongsURL,  method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers   )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    var songs : [Song] = []
                    for singleJsonItem in jsonData["songs"] {
                        songs.append(Song.fromJson(jsonData: singleJsonItem.1))
                    }
                    print("success search Songs")
                    completed(true, songs)
                case let .failure(error):
                    print(error.errorDescription)
                    completed(false, [])
                    debugPrint(error)
                    
                }
            }
    }
}
