//
//  Song.swift
//  songHaven-IOS
//
//  Created by zewaff on 26/11/2022.
//

import SwiftyJSON
struct Song : Decodable, Equatable{
    
    internal init(_id: String? = nil, title: String? = nil, genre: String? = nil, filename: String? = nil, duration: Double? = nil, isPublished: Bool? = nil, creator: User? = nil) {
        self._id = _id
        self.title = title
        self.genre = genre
        self.duration = duration
        self.filename = filename
        self.isPublished = isPublished
        self.creator = creator
    }
    
    var _id : String?
    var title : String?
    var genre  : String?
    var filename : String?
    var duration : Double?
    var isPublished : Bool?
    var creator : User?
    
    // relations
    
    static func fromJson(jsonData: JSON) -> Song {
        return Song(
            _id: jsonData["_id"].stringValue,
            title: jsonData["title"].stringValue,
            genre: jsonData["genre"].stringValue,
            filename: jsonData["filename"].stringValue,
            duration: jsonData["duration"].doubleValue,
            isPublished: jsonData["isPublished"].boolValue,
            creator : User.fromJson(jsonData: jsonData["creator"])
        )
    }
    
    static func == (lhs: Song, rhs: Song) -> Bool {
        return lhs._id == rhs._id
    }
}
