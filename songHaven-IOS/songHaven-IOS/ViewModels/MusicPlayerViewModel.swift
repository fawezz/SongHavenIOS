//
//  MusicPlayerViewModel.swift
//  songHaven-IOS
//
//  Created by zewaff on 20/11/2022.
//

import Foundation

class MusicPlayerViewModel: ObservableObject {
    
    let model: String//MusicModel
    
    @Published var liked = true
    @Published var slider: Double = 30
    @Published var isPlaying = true
    @Published var SongImageUrl : URL = URL(string: UserService.UserImageUrl + "songDefaultImage.png")!
    
//    init(model: MusicModel) {
//        self.model = model
//    }
    
    init(model: String, liked: Bool = true, slider: Double, isPlaying: Bool = true) {
        self.model = model
        self.liked = liked
        self.slider = slider
        self.isPlaying = isPlaying
    }
}
