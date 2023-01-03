//
//  Event.swift
//  songHaven-IOS
//
//  Created by SongH on 20/12/2022.
//

import SwiftyJSON
import Foundation

struct Event :Decodable{
    internal init(_id: String? = nil, title: String? = nil, description: String? = nil, dateEvent: Date? = nil,  eventCreator: Band? = nil, latitud: String? = nil  ,longitud: String? = nil ) {
        
        self._id = _id
        self.title = title
        self.description  = description
        self.eventCreator = eventCreator
        self.dateEvent = dateEvent
        self.latitud = latitud
        self.longitud = longitud
    }
    var _id : String?
    var title : String?
    var description : String?
    var eventCreator : Band?
    var latitud : String?
    var longitud : String?
    var dateEvent : Date?
    static func fromJson(jsonData: JSON) -> Event {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        let dateEvent = dateFormatter.date(from: jsonData["createdAt"].stringValue)
        
            return Event(
                _id: jsonData["_id"].stringValue,
                title: jsonData["title"].stringValue,
                description: jsonData["description"].stringValue,
                dateEvent: dateEvent,
                eventCreator: Band.fromJson(jsonData:jsonData["eventCreator"]),
                latitud: jsonData["latitud"].stringValue,
                longitud: jsonData["longitud"].stringValue
   
             
                
            )  }
    
    
    
    
    
}
