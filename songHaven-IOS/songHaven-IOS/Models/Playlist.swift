//
//  Playlist.swift
//  songHaven-IOS
//
//  Created by zewaff on 27/11/2022.
//

import SwiftyJSON
struct Playlist : Decodable{
    
    internal init(_id: String? = nil, title: String? = nil,songs: [Song]? = nil, ownerId: String? = nil) {
        self._id = _id
        self.title = title
        self.songs = songs
        self.ownerId = ownerId
    }
    
    var _id : String?
    var title : String?
    var ownerId : String?
    var songs : [Song]?
    
    // relations
    
    static func fromJson(jsonData: JSON) -> Playlist {
        var songs : [Song]? = []
        for singleJsonItem in jsonData["songs"] {
            songs!.append(Song.fromJson(jsonData: singleJsonItem.1))
        }
            return Playlist(
                _id: jsonData["_id"].stringValue,
                title: jsonData["title"].stringValue,
                songs: songs,
                ownerId : jsonData["owner"].stringValue
            )
        }
}
