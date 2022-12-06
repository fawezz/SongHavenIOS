//
//  MusicHomeViewModel.swift
//  songHaven-IOS
//
//  Created by zewaff on 26/11/2022.
//

import Foundation
@MainActor class MusicHomeViewModel: ObservableObject {
    @Published var pupularSongs = [Song]()
    @Published var newestSongs = [Song]()
    @Published var userPlaylists = [Playlist]()
    @Published var searchText : String = ""
    
    @Published var isLoading = false
    
    init() {
        fetchUserPlaylists()
        fetchNewestSongs()
        fetchPopularSongs()
    }
    
    private func fetchUserPlaylists() {
        PlaylistService.GetByUser(completed: { (success, playlistArray) in
            if(success){
                self.userPlaylists = playlistArray ?? []
            }
        })
    }
    
    private func fetchNewestSongs() {
        SongService.GetAllSongs(completed: {(success, songsArray) in
            if(success){
                self.newestSongs = songsArray ?? []
                //
                self.pupularSongs = songsArray ?? []
            }
        })
    }
    
    private func fetchPopularSongs() {
//        SongService.GetMostPopular(completed: {(success, songsArray) in
//            if(success){
//                self.newestSongs = songsArray ?? []
//            }
//        })
    }
    

    func isDataReceived() -> Bool{
        
        return !self.newestSongs.isEmpty && !self.pupularSongs.isEmpty
    }
    
    
    
}
