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
    @Published var showAlert = false
    
    init(playlist: Playlist) {
        self.selectedPlaylist = playlist
        self.songs = playlist.songs ?? []
        self.fetchPopularSongs()
    }
    
    
    private func fetchPopularSongs() {

    }
    
    func selectMusic(music: Song) {
        selectedMusic = music
        displayPlayer = true
    }
    
    func removeSongFromPlaylist(swipedSong: Song) {
        //remove song
        PlaylistService.RemoveSong(playlistId: selectedPlaylist._id!, songId: swipedSong._id!, completed:
                                    { (success, reponse) in
            if(success){
                self.songs = reponse!.songs!
                print("song removed successfully")
            }
        })
        
    }
    
    func deletePlaylist(action: ()){
        PlaylistService.DeletePlaylist(playlistId: selectedPlaylist._id!, completed:
                                                    { (success, reponse) in
            if(success){
                action
            }
        })
    }
    
}
