//
//  MusicPlayerViewModel.swift
//  songHaven-IOS
//
//  Created by zewaff on 20/11/2022.
//

import Foundation
import AVFoundation

class MusicPlayerViewModel: ObservableObject {
    
    @Published var showSheet = false
    public static var config:Configurations?
    @Published var slider: Double = 0
    @Published var minutes: Int = 0
    @Published var seconds: Int = 0
    @Published var isPlaying: Bool = true
    @Published var duration: Int = 10

    
    static let shared: MusicPlayerViewModel = {
        let instance = MusicPlayerViewModel()
        return instance
    }()
    
    class func setup(_ config:Configurations){
        if(MusicPlayerViewModel.config == nil || config.model._id != MusicPlayerViewModel.config?.model._id)
        {
            MusicPlayerViewModel.config = config
            self.shared.updateTimer()
            //self.shared.slider = MusicPlayerViewModel.config!.slider
//            self.shared.minutes = MusicPlayerViewModel.config!.minutes
//            self.shared.seconds = MusicPlayerViewModel.config!.seconds
//            self.shared.duration = Music

        }
    }
    func updateTimer(){
        self.duration = MusicPlayerViewModel.config!.duration
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ (_) in
            if(MusicPlayerViewModel.config!.isPlaying){
                print(MusicPlayerViewModel.config!.player.currentTime().seconds)
                self.slider = (MusicPlayerViewModel.config!.player.currentItem?.currentTime().seconds)!
                self.minutes = Int((self.slider / 60))
                self.seconds = Int((self.slider.truncatingRemainder(dividingBy: 60).rounded()))
                self.isPlaying = MusicPlayerViewModel.config!.isPlaying
                print("seconds", self.seconds )
                print("minutes", self.minutes )
            }
        }
        print((MusicPlayerViewModel.config!.player.currentItem?.duration.seconds.rounded())!)
    }
    
    private init() {
        //            guard let config = MusicPlayerViewModel.config else {
        //                        fatalError("Error - you must call setup before accessing MySingleton.shared")
        //                    }
    }
    
    
    
    //    func playNextSong(){
    //        var index =  self.playlist?.songs!.firstIndex(of: model) ?? 0
    //        if index < ((self.playlist?.songs!.count)! - 1) {
    //            index = index + 1
    //        }
    //
    //        self.player.insert(queuedSongs[index], after: self.player.currentItem)
    //        self.player.advanceToNextItem()
    //        self.player.play()
    //        isPlaying = true
    //        self.model = (playlist?.songs![index])!
    //    }
    //
    //    func playPreviousSong(){
    //        var index =  self.playlist?.songs!.firstIndex(of: model) ?? 0
    //        if index > 0 {
    //            index = index - 1
    //        }
    //        else{
    //            index = queuedSongs.count - 1
    //        }
    //        self.player.replaceCurrentItem(with: queuedSongs[index])
    //        self.player.play()
    //        isPlaying = true
    //        self.model = (playlist?.songs![index])!
    //
    //    }
}

struct Configurations {
     var model: Song
    let playlist: Playlist?
     var player : AVQueuePlayer!
     var liked = true
     var slider: Double = 0
     var isPlaying = true
     var SongImageUrl : URL = URL(string: UserService.UserImageUrl + "songDefaultImage.png")!
     var duration: Int = 10
     var minutes: Int = 0
     var seconds: Int = 0
     var queuedSongs: [AVPlayerItem] = []
    
    init(model: Song, currentPlaylist: Playlist?, liked: Bool = true, showSheet: Bool = false) {
        self.playlist = currentPlaylist
        
        self.model = model
        self.player = AVQueuePlayer(url: URL(string: SongService.songMusicUrl + model.filename!)! )
        self.player.volume = 10
        self.player.playImmediately(atRate: 1)
        self.isPlaying = true
        
//        var observer = self.player.currentItem!.observe(\.status, options:  [.new, .old], changeHandler: { (playerItem, change) in
//                if playerItem.status == .readyToPlay {
//                    self.duration = Int(playerItem.duration.seconds.rounded())
//                }
//            })
        
        if((currentPlaylist) != nil){
            currentPlaylist!.songs?.forEach { songItem in
                queuedSongs.append(AVPlayerItem(url: URL(string: SongService.songMusicUrl + songItem.filename!)!))
            }
        }
    }

    
}
