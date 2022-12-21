//
//  ArtistEventsViewModel.swift
//  songHaven-IOS
//
//  Created by SongH on 20/12/2022.
//

import Foundation
@MainActor class ArtistEventsViewModel: ObservableObject {
    @Published var navigator : String? = nil
    @Published var ArtistEvents = [Event]()
    @Published var searchText : String = ""
    
    init() {
        fetchArtistEvents()
    }
    
    func  fetchArtistEvents() {
        EventService.getEventByOwner (completed: { (success, eventArray) in
            if(success){
                self.ArtistEvents = eventArray ?? []
            }
        })
    }
}
