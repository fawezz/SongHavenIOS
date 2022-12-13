//
//  EditPlaylistViewModel.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 4/12/2022.
//

import Foundation
@MainActor class EditPlaylistViewModel: ObservableObject {
    
    @Published var song : Song
    @Published var userPlaylists : [Playlist] = []
    
    @Published var isLoading : Bool = true
    @Published var showCreationSheet : Bool = false
    @Published var newPlaylistTitle : String = ""
    
    init(song: Song) {
        self.song = song
        fetchUserPlaylists()
    }
    
    private func fetchUserPlaylists() {
        PlaylistService.GetByUser(completed: { (success, playlistArray) in
            if(success){
                self.userPlaylists = playlistArray ?? []
                self.isLoading = false
            }
        })
    }
    
    func createPlaylist() {
        PlaylistService.CreatePlaylist(title: newPlaylistTitle, songs: [], completed:
                                                    { (success, reponse) in
            if(success){
                //let p : Playlist = reponse!
                //self.addSongToPlaylist(selectedPlaylist: p)
            }
            
        })
    }
    
    func songExists(songList: [Song]) -> Bool{
        return songList.contains(song)
        
    }
    
    func addSongToPlaylist(selectedPlaylist: Playlist) -> Bool {
        if((selectedPlaylist.songs?.contains(song)).unsafelyUnwrapped){
            //remove song
            PlaylistService.RemoveSong(playlistId: selectedPlaylist._id!, songId: song._id!, completed:
                                        { (success, reponse) in
                if(success){
                    print("song removed successfully")
                }
            })
            
            return false
        }else{
            //add song
            PlaylistService.AddSong(playlistId: selectedPlaylist._id!, songId: song._id!, completed:
                                        { (success, reponse) in
                if(success){
                    print("song added successfully")
                }
            })
        }
        
        return true
    }
    
    
    func validateFields()-> Bool{
        //return true
        return (self.newPlaylistTitle.count > 0 )
    }
    
}
