//
//  MusicPlayerViewModel.swift
//  songHaven-IOS
//
//  Created by zewaff on 20/11/2022.
//

import Foundation
import AVFoundation
import MediaPlayer
import UIKit

class MusicPlayerViewModel: ObservableObject {
    
    @Published var showSheet = false
    public static var config:Configurations?
    @Published var slider: Double = 0
    @Published var minutes: Int = 0
    @Published var seconds: Int = 0
    @Published var isPlaying: Bool = (config?.isPlaying)!
    @Published var duration: Int = 10
    @Published var liked = false


    private init() {}

    static let shared: MusicPlayerViewModel = {
        let instance = MusicPlayerViewModel()
        return instance
    }()
    
    class func setup(_ config:Configurations){
        let firstConfig : Bool = MusicPlayerViewModel.config == nil
        if(firstConfig || config.model._id != MusicPlayerViewModel.config?.model._id ||
           config.playlist?._id != MusicPlayerViewModel.config?.playlist?._id)
        {
            MusicPlayerViewModel.config = config
            MusicPlayerViewModel.shared.isPlaying = true
            if(firstConfig){ // to make sure update timer is called only once
                self.shared.updateTimer()
            }
        }
    }
    
    func updateTimer(){
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ (_) in
            if(self.isPlaying && self.showSheet == false){
                self.slider = (MusicPlayerViewModel.config!.player.currentItem?.currentTime().seconds)!
                self.minutes = Int((self.slider / 60))
                self.seconds = Int((self.slider.truncatingRemainder(dividingBy: 60).rounded()))
                //self.isPlaying = MusicPlayerViewModel.config!.isPlaying
                print("seconds", self.seconds )
                print("minutes", self.minutes )
            }
        }
        print((MusicPlayerViewModel.config!.player.currentItem?.duration.seconds.rounded())!)
        self.duration = MusicPlayerViewModel.config!.duration
    }
    
    func toggleLike(){
        LikeService.toggleLike(songId: (MusicPlayerViewModel.config?.model._id)!, completed: { (success, reponse) in
            if success {
                print("success toggled like")
                self.liked = reponse ?? self.liked
            } else {
                print("fail toggle like")
            }
        })
    }
    func isLikedByUser(){
        LikeService.isLikedByUser(songId: (MusicPlayerViewModel.config?.model._id)!, completed: { (success, reponse) in
            if success {
                print("received like " + success.description)
                self.liked = reponse ?? self.liked
            } else {
                print("fail receive like")
            }
        })
    }
    
        func playNextSong(){
            var index =  MusicPlayerViewModel.config?.playlist?.songs!.firstIndex(of: MusicPlayerViewModel.config!.model) ?? 0
            if index < ((MusicPlayerViewModel.config?.playlist?.songs!.count)! - 1) {
                index = index + 1
            }else{
                index = 0
            }
    
            //MusicPlayerViewModel.config?.player.insert((MusicPlayerViewModel.config?.queuedSongs[index])!, after: MusicPlayerViewModel.config?.player.currentItem)
            //MusicPlayerViewModel.config?.player.advanceToNextItem()
            MusicPlayerViewModel.config?.player.seek(to: CMTime.zero)
            MusicPlayerViewModel.config?.player.replaceCurrentItem(with: MusicPlayerViewModel.config?.queuedSongs[index])
            MusicPlayerViewModel.config?.player.play()
            isPlaying = true
            let nextSong = (MusicPlayerViewModel.config?.playlist?.songs![index])!
            MusicPlayerViewModel.config?.model = nextSong
            //updateTimer()
        }
    
        func playPreviousSong(){
            var index =  MusicPlayerViewModel.config?.playlist?.songs!.firstIndex(of: MusicPlayerViewModel.config!.model) ?? 0
            if index > 0 {
                index = index - 1
            }
            else{
                index = (MusicPlayerViewModel.config?.queuedSongs.count)! - 1
            }
            MusicPlayerViewModel.config?.player.seek(to: CMTime.zero)
            MusicPlayerViewModel.config?.player.replaceCurrentItem(with: MusicPlayerViewModel.config?.queuedSongs[index])
            MusicPlayerViewModel.config?.player.play()
            isPlaying = true
            let previousSong = (MusicPlayerViewModel.config?.playlist?.songs![index])!
            MusicPlayerViewModel.config?.model = previousSong
            //updateTimer()
        }
    
    
    func setupRemoteTransportControls() {
        // Get the shared MPRemoteCommandCenter
        
        let commandCenter = MPRemoteCommandCenter.shared()

        // Add handler for Play Command
        commandCenter.playCommand.addTarget { [unowned self] event in
            print("Play command - is playing: \(MusicPlayerViewModel.config!.isPlaying)")
            if !MusicPlayerViewModel.config!.isPlaying {
                MusicPlayerViewModel.config!.player.play()
                MusicPlayerViewModel.config!.isPlaying = true
                return .success
            }
            return .commandFailed
        }

        // Add handler for Pause Command
        commandCenter.pauseCommand.addTarget { [unowned self] event in
            print("Pause command - is playing: \(MusicPlayerViewModel.config!.isPlaying)")
            if MusicPlayerViewModel.config!.isPlaying {
                MusicPlayerViewModel.config!.player.pause()
                MusicPlayerViewModel.config!.isPlaying = false
                return .success
            }
            return .commandFailed
        }
    }

    func setupNowPlaying() {
        // Define Now Playing Info
        var nowPlayingInfo = [String : Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = "Unstoppable"

        if let image = UIImage(named: "artist") {
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { size in
                return image
            }
        }
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = MusicPlayerViewModel.config?.player.currentTime
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = MusicPlayerViewModel.config?.player.currentItem?.duration
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = MusicPlayerViewModel.config?.player.rate

        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    func play() {
        MusicPlayerViewModel.config!.player.play()
        //playPauseButton.setTitle("Pause", for: UIControl.State.normal)
        updateNowPlaying(isPause: false)
        print("Play - current time: \(String(describing: MusicPlayerViewModel.config!.player.currentTime)) - is playing: \(MusicPlayerViewModel.config!.isPlaying)")
    }
    
    func pause() {
        MusicPlayerViewModel.config!.player.pause()
        //playPauseButton.setTitle("Play", for: UIControl.State.normal)
        updateNowPlaying(isPause: true)
        print("Pause - current time: \(String(describing: MusicPlayerViewModel.config!.player.currentTime)) - is playing: \(MusicPlayerViewModel.config!.isPlaying)")
    }

    func updateNowPlaying(isPause: Bool) {
        // Define Now Playing Info
        var nowPlayingInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo!

        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = MusicPlayerViewModel.config!.player.currentTime
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = isPause ? 0 : 1

        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
}

struct Configurations {
     var model: Song
    let playlist: Playlist?
     var player : AVQueuePlayer!
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
