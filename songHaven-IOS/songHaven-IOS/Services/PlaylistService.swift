//
//  PlaylistService.swift
//  songHaven-IOS
//
//  Created by zewaff on 27/11/2022.
//

import Alamofire
import SwiftyJSON
import Foundation
import UIKit

class PlaylistService{
    static let getByUserURL = Constants.HOSTNAME + "/playlist/getByUser/"
    static let createURL = Constants.HOSTNAME + "/playlist/create"
    static let modifyURL = Constants.HOSTNAME + "/playlist/modify"
    static let deletePlaylistURL = Constants.HOSTNAME + "/playlist/delete/"
    static let addSongURL = Constants.HOSTNAME + "/playlist/addSong"
    static let removeSongURL = Constants.HOSTNAME + "/playlist/removeSong"
    
    
    static func GetByUser(completed: @escaping (Bool, [Playlist]?) -> Void){
        let userId : String = UserDefaults.standard.string(forKey: "userId")!
        AF.request(getByUserURL + userId,  method: .get ) //"63749eac6781be3df2521807"
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    var playlists : [Playlist]? = []
                    for singleJsonItem in jsonData["playlists"] {
                        playlists!.append(Playlist.fromJson(jsonData: singleJsonItem.1))
                    }
                    //print("success received Playlists: " + (playlists?.description)!)
                    completed(true, playlists)
                case let .failure(error):
                    print(error)
                    completed(false, [])
                    debugPrint(error)
                }
            }
    }
    static func AddSong(playlistId: String, songId: String, completed: @escaping (Bool, Playlist?) -> Void){
        
        let headers : HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [
            "songId" : songId,
            "playlistId" : playlistId
        ]
        
        AF.request(addSongURL,  method: .put, parameters: params, encoder: JSONParameterEncoder.default, headers: headers  )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let playlist = Playlist.fromJson(jsonData: jsonData["playlist"])
                    print("success added song to: " + playlist.title!)
                    completed(true, playlist)
                case let .failure(error):
                    debugPrint(error.errorDescription!)
                    completed(false, nil)
                    
                    
                }
            }
    }
    static func RemoveSong(playlistId: String, songId: String, completed: @escaping (Bool, Playlist?) -> Void){
        
        let headers : HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [
            "songId" : songId,
            "playlistId" : playlistId
        ]
        
        AF.request(removeSongURL,  method: .put, parameters: params, encoder: JSONParameterEncoder.default, headers: headers  )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let playlist = Playlist.fromJson(jsonData: jsonData["newPlaylist"])
                    print("success removed song from: " + playlist.title!)
                    completed(true, playlist)
                case let .failure(error):
                    debugPrint(error.errorDescription!)
                    completed(false, nil)
                }
            }
    }
    //RODDHA TAKHOU SONG WA7DA///////////////
    static func CreatePlaylist(title: String,songs: [String]?, completed: @escaping (Bool, Playlist?) -> Void){
        let userId : String = UserDefaults.standard.string(forKey: "userId")!
        let headers : HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [
            "title" : title,
            "ownerId" : userId,
            //"songs" : try! JSONSerialization.data(withJSONObject: songs)
        ]
        
        AF.request(createURL,  method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers  )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let playlist = Playlist.fromJson(jsonData: jsonData["playlist"])
                    completed(true, playlist)
                case let .failure(error):
                    debugPrint(error.errorDescription!)
                    completed(false, nil)
                }
            }
    }
    
    static func ModifyPlaylist(playlistId: String, title: String, completed: @escaping (Bool, String?) -> Void){
        let headers : HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [
            "playlistId" : playlistId,
            "title" : title
        ]
        AF.request(modifyURL,  method: .put, parameters: params, encoder: JSONParameterEncoder.default, headers: headers )
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
                    debugPrint(error)
                    let jsonData = JSON(response.data!)
                    let message = jsonData["message"].stringValue
                    print(message)
                    completed(false, message)
                }
            }
    }
    
    static func DeletePlaylist(playlistId: String, completed: @escaping (Bool, String) -> Void){
        AF.request(deletePlaylistURL + playlistId,  method: .delete )
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
    
}
