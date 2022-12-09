//
//  ProfileViewModel.swift
//  songHaven-IOS
//
//  Created by zewaff on 12/11/2022.
//
import SwiftUI
import NavigationStack
@MainActor class ProfileViewModel: ObservableObject {
    
    @Published var navigator : String? = nil
    @Published var showLogoutAlert : Bool = false
    @Published var showDeleteAlert : Bool = false
    @Published var userSongs : [Song] = []
    @Published var totalLikes : Int = 0
    @Published var profileImageUrl: URL = URL(string: UserService.UserImageUrl + UserDefaults.standard.string(forKey: "imageId")!)!
    @Published var isLoading = true
    
    let firstname : String = UserDefaults.standard.string(forKey: "firstname")!
    let lastname : String = UserDefaults.standard.string(forKey: "lastname")!
    
    init() {
        fetchUserSongs()
        fetchTotalLikes()
    }
    
    func fetchUserSongs(){
        SongService.GetByCurrentUser( completed: {
            (success, reponse) in
            self.userSongs = reponse
            print("received user songs")
            
        })
    }
    func fetchTotalLikes(){
        LikeService.getArtistTotalLikes( completed: {
            (success, reponse) in
            self.totalLikes = reponse
            print(self.totalLikes.description)
        })
    }
    
    func removeSong(swipedSong: Song){
        SongService.DeleteSong(songId: swipedSong._id!, completed: {
            (success, reponse) in
            if(success){
                print("success song deleted")
                guard let index = self.userSongs.firstIndex(of: swipedSong) else {return}
                self.userSongs.remove(at: index)
            }
        })
    }
    
    func Logout(){
        UserDefaults.standard.setValue(
            nil,forKey: "token"
        )
//        UserDefaults.standard.setValue(
//            nil,forKey: "email"
//        )
//        UserDefaults.standard.setValue(
//            nil,forKey: "userId"
//        )
//        UserDefaults.standard.setValue(
//            nil,forKey: "firstname"
//        )
//        UserDefaults.standard.setValue(
//            nil,forKey: "lastname"
//        )
    }
}
