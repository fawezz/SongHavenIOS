//
//  Location.swift
//  songHaven-IOS
//
//  Created by SongH on 22/12/2022.
//

import Foundation
struct Location : Identifiable , Codable,Equatable{
let id: UUID
    var name : String
    var description : String
    let latitude : Double
    let longtude : Double
}
