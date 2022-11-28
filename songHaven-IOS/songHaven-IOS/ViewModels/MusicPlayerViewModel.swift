//
//  MusicPlayerViewModel.swift
//  songHaven-IOS
//
//  Created by zewaff on 20/11/2022.
//

import Foundation
import AVFoundation

class MusicPlayerViewModel: ObservableObject {
    
    let model: String
    
    @Published var player : AVPlayer!
    @Published var liked = true
    @Published var slider: Double = 30
    @Published var isPlaying = true
    @Published var SongImageUrl : URL = URL(string: UserService.UserImageUrl + "songDefaultImage.png")!
    @Published var duration: Int = 100
    
    init(model: String) {
        self.model = model
//        self.player =  try! AVAudioPlayer(contentsOf: URL(string: SongService.songMusicUrl + "music1669159393115.mp3")!)
//        self.player.prepareToPlay()
//        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ (_) in
//            if(self.player.isPlaying){
//                print(self.player.currentTime)
//            }
//        }
        
    }
    
    init(model: String, liked: Bool = true, slider: Double, isPlaying: Bool = true) {
        self.model = model
        self.liked = liked
        self.player = AVPlayer(url: URL(string: SongService.songMusicUrl)!)
        self.player.volume = 100
        self.player.playImmediately(atRate: 1)
        self.slider = slider
        self.isPlaying = isPlaying
        //self.duration = Int(exactly: (self.player.currentItem?.duration.seconds.rounded())!)!
        //self.duration = Int(exactly: CMTimeGetSeconds(self.player.currentItem!.duration))!
        
        
        //let item = AVPlayerItem(url: )
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ (_) in
                    if(self.isPlaying){
                        print(self.player.currentTime().seconds)
                        self.slider = (self.player.currentItem?.currentTime().seconds)!
                        
                        print((self.player.currentItem?.duration.seconds.rounded())!)
                    }
                }
    }
}
