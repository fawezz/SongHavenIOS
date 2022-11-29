//
//  MusicPlayerViewModel.swift
//  songHaven-IOS
//
//  Created by zewaff on 20/11/2022.
//

import Foundation
import AVFoundation

class MusicPlayerViewModel: ObservableObject {
    
//        static let shared: MusicPlayerViewModel = {
//            let instance = MusicPlayerViewModel()
//            return instance
//        }()
    
    
    @Published var model: Song
    let playlist: Playlist?
    
    @Published var player : AVQueuePlayer!
    @Published var liked = true
    @Published var slider: Double = 0
    @Published var isPlaying = true
    @Published var SongImageUrl : URL = URL(string: UserService.UserImageUrl + "songDefaultImage.png")!
    @Published var duration: Int = 100
    @Published var showSheet = false
    @Published var minutes: Int = 0
    @Published var seconds: Int = 0
    @Published var queuedSongs: [AVPlayerItem] = []
    
    
    
    init(model: Song, currentPlaylist: Playlist?) {
        self.playlist = currentPlaylist
        
        self.model = model
        self.player = AVQueuePlayer(url: URL(string: SongService.songMusicUrl + model.filename!)! )
        self.player.volume = 10
        self.player.playImmediately(atRate: 1)
        self.isPlaying = true
        self.duration = Int(exactly: (self.player.currentItem?.duration.seconds)!) ?? 120
        updateTimer()
        if((currentPlaylist) != nil){
            currentPlaylist!.songs?.forEach { songItem in
                queuedSongs.append(AVPlayerItem(url: URL(string: SongService.songMusicUrl + songItem.filename!)!))
            }
        }
    }
    
    init(model: Song, currentPlaylist: Playlist?, liked: Bool = true, slider: Double, isPlaying: Bool = true) {
        self.playlist = currentPlaylist
        self.model = model
        self.liked = liked
        let item = AVPlayerItem(url: URL(string: SongService.songMusicUrl + model.filename!)!)
        self.player = AVQueuePlayer(playerItem: item)
        self.player.volume = 100
        self.player.playImmediately(atRate: 1)
        self.slider = slider
        self.isPlaying = isPlaying
        self.duration = Int(exactly: (self.player.currentItem?.duration.seconds)!) ?? 120
        //self.duration = Int(exactly: CMTimeGetSeconds(self.player.currentItem!.duration))!
        updateTimer()
        
        print((self.player.currentItem?.duration.seconds.rounded())!)
        
    }
    
    func updateTimer(){
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ (_) in
            if(self.isPlaying){
                print(self.player.currentTime().seconds)
                self.slider = (self.player.currentItem?.currentTime().seconds)!
                self.minutes = Int((self.slider / 60))
                self.seconds = Int((self.slider.truncatingRemainder(dividingBy: 60).rounded()))
                print("seconds", self.seconds )
                print("minutes", self.minutes )
            }
        }
        print((self.player.currentItem?.duration.seconds.rounded())!)
    }
    
    func playNextSong(){
        var index =  self.playlist?.songs!.firstIndex(of: model) ?? 0
        if index < ((self.playlist?.songs!.count)! - 1) {
            index = index + 1
        }
        
        self.player.insert(queuedSongs[index], after: self.player.currentItem)
        self.player.advanceToNextItem()
        self.player.play()
        isPlaying = true
        self.model = (playlist?.songs![index])!
    }
    
    func playPreviousSong(){
        var index =  self.playlist?.songs!.firstIndex(of: model) ?? 0
        if index > 0 {
            index = index - 1
        }
        else{
            index = queuedSongs.count - 1
        }
        self.player.replaceCurrentItem(with: queuedSongs[index])
        self.player.play()
        isPlaying = true
        self.model = (playlist?.songs![index])!

    }
}

