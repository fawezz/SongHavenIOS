//
//  PlaylistDetailsViewModel.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 28/11/2022.
//

import Foundation
@MainActor class PlaylistDetailsViewModel: ObservableObject {
    @Published var selectedPlaylist : Playlist
    @Published var songs : [Song]
    
    @Published var searchText : String = ""
    @Published var selectedMusic: Song? = nil
    @Published var displayPlayer = false
    
    init(playlist: Playlist) {
        self.selectedPlaylist = playlist
        self.songs = playlist.songs ?? []
        self.fetchPopularSongs()
    }

    
    private func fetchPopularSongs() {
//        SongService.GetMostPopular(completed: {(success, songsArray) in
//            if(success){
//                self.newestSongs = songsArray ?? []
//            }
//        })
    }
    
    func selectMusic(music: Song) {
        selectedMusic = music
        displayPlayer = true
    }
    
}
