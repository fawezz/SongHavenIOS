//
//  MusicSearchViewModel.swift
//  songHaven-IOS
//
//  Created by zewaff on 6/12/2022.
//


import Foundation
@MainActor class MusicSearchViewModel: ObservableObject {
    @Published var searchedSongs = [Song]()
    @Published var searchText : String
    @Published var criteria : String
    @Published var isLoading = true
    
    init(criteria: String, searchText: String) {
        self.searchText = searchText
        self.criteria = criteria
        searchSongs()
    }
    
    func searchSongs() {
        SongService.SearchSongs(criteria: self.criteria, searchText: self.searchText, completed: {(success, songsArray) in
            if(success){
                self.searchedSongs = songsArray
                self.isLoading = false
            }else{
                self.isLoading = false
            }
        })
    }
        
//
//    func isDataReceived() -> Bool{
//
//        return !self.searchedSongs.isEmpty
//    }
    
    
    
}
