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
    let ip = "http://192.168.0.3:9090"
    static let getByUserURL = "http://192.168.0.3:9090/playlist/getByUser/"
    static let createURL = "http://192.168.0.3:9090/playlist/create"
    static let modifyURL = "http://192.168.0.3:9090/playlist/modify"
    static let deletePlaylistURL = "http://192.168.0.3:9090/playlist/delete/"
    static let addSongURL = "http://192.168.0.3:9090/playlist/addSong"
    static let removeSongURL = "http://192.168.0.3:9090/playlist/removeSong"
    
    
    static func GetByUser(ownerId: String, completed: @escaping (Bool, [Playlist]?) -> Void){
        AF.request(getByUserURL + "63749eac6781be3df2521807"/*creatorId*/,  method: .get )
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
                    print("success received Playlists: " + (playlists?.description)!)
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
                    let playlist = Playlist.fromJson(jsonData: jsonData["playlist"])
                    print("success removed song from: " + playlist.title!)
                    completed(true, playlist)
                case let .failure(error):
                    debugPrint(error.errorDescription!)
                    completed(false, nil)
                }
            }
    }
    static func CreatePlaylist(title: String, ownerId: String,songs: [String], completed: @escaping (Bool, Playlist?) -> Void){
        print(songs)
        let headers : HTTPHeaders = [
            .contentType("application/json"),
            .accept("application/json")
        ]
        let params = [
            "title" : title,
            "ownerId" : ownerId,
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
                    print("success removed song from: " + playlist.title!)
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
    
    static func DeletePlaylist(songId: String, completed: @escaping (Bool, String?) -> Void){
        AF.request(deletePlaylistURL + "637d586fe95ad20baf9a47e0"/*songId*/,  method: .delete )
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
