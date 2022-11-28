//
//  MusicHomeViewModel.swift
//  songHaven-IOS
//
//  Created by zewaff on 26/11/2022.
//

import Foundation
@MainActor class MusicHomeViewModel: ObservableObject {
    @Published private(set) var headerStr = "Hello Sameer 👋🏻"
    @Published private(set) var playlists = [Song]()
    @Published private(set) var recentlyPlayed = [Song]()
    
    @Published private(set) var selectedMusic: Song? = nil
    @Published var displayPlayer = false
    
    init() {
        fetchPlaylist()
        fetchRecentlyPlayed()
    }
    
    private func fetchPlaylist() {
        //playlists = Data.getPlaylists()
    }
    
    private func fetchRecentlyPlayed() {
        //recentlyPlayed = Data.getRecentlyPlayed()
    }
    
    func selectMusic(music: Song) {
        selectedMusic = music
        displayPlayer = true
    }
    
}
