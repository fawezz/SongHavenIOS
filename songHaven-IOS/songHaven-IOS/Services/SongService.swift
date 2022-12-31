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
import AVFAudio

class SongService{
    static let getAllURL = Constants.HOSTNAME + "/song/getAll"
    static let getByUserURL = Constants.HOSTNAME + "/song/getByUser/"
    static let createURL = Constants.HOSTNAME + "/song/create"
    static let modifyeURL = Constants.HOSTNAME + "/song/modify"
    static let deleteSongURL = Constants.HOSTNAME + "/song/delete/"
    static let songImageUrl = Constants.HOSTNAME + "/img/"
    static let songMusicUrl = Constants.HOSTNAME + "/music/" //+ "music1669159393115.mp3"
    static let searchSongsURL = Constants.HOSTNAME + "/song/search"
    
    static func createSong(title : String, genre: String , songfileURL :URL , completed:@escaping(Bool,Int)->Void){
        do{
            let audioData = try Data(contentsOf: songfileURL)
            let audioPlayer = try AVAudioPlayer(contentsOf: songfileURL)
            let duration = Int(floor(audioPlayer.duration))
            print(duration)
            
            let headers : HTTPHeaders = [
                .contentType("multipart/form-data")
            ]
            AF.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(audioData, withName: "music",fileName: "audio.mp3",mimeType: "audio/mp3")
                    multipartFormData.append((UserSession.shared.currentUser?._id!.data(using: String.Encoding.utf8)!)!, withName: "creatorId")
                    multipartFormData.append(genre.data(using: String.Encoding.utf8)!, withName: "genre")
                    multipartFormData.append(title.data(using: String.Encoding.utf8)!, withName: "title")
                    multipartFormData.append("\(duration)".data(using: String.Encoding.utf8)!, withName: "duration")
                    
                },to: self.createURL, method: .post, headers: headers)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch(response.result){
                case .success:
                    print("song created")
                    let jsonData = JSON(response.data!)
                    //let message = jsonData["band"].stringValue
                    //print(jsonData)
                    completed(true,200)
                case .failure(let error):
                    print(error)
                    completed(false,error.responseCode!)
                }
                
            }
        }catch{
            print(error)
        }
    }
    
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
    
    static func GetByCurrentUser(completed: @escaping (Bool, [Song]) -> Void){
        let creatorId = UserDefaults.standard.string(forKey: "userId")!
        AF.request(getByUserURL + creatorId,  method: .get )
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
                    print("success received Songs: " + songs.count.description)
                    completed(true, songs)
                case let .failure(error):
                    print(error)
                    completed(false, [])
                    debugPrint(error)
                }
            }
    }
    
    static func DeleteSong(songId: String, completed: @escaping (Bool, String?) -> Void){
        AF.request(deleteSongURL + songId,  method: .delete )
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
