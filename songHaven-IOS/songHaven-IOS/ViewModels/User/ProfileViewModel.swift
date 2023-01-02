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
    let firstname : String = (UserSession.shared.currentUser?.firstname)!
    let lastname : String = (UserSession.shared.currentUser?.lastname)!
    @Published var profileImageUrl: URL = URL(string: UserService.UserImageUrl + (UserSession.shared.currentUser?.imageId)!)!
    @Published var isLoading = true
    @Published var showLanguageSheet = false
    @Published var selectedLang = ""
    @Published var showWebView = false


    @Published var lang = LocalizationService.shared.language

    var langs = ["English", "French"]
    
    init() {
        if(LocalizationService.shared.language == .english_us){
            selectedLang = langs[0]
        }else{
            selectedLang = langs[1]

        }
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
    func applyChangeLang(){
        if(selectedLang == "French")
            {
                LocalizationService.shared.language = .french
        }else {
            LocalizationService.shared.language = .english_us
        }
        print("changed language to " + selectedLang)
    }
    
    func Logout(){
        UserDefaults.standard.setValue(
            nil,forKey: "token"
        )
        UserSession.shared.isSignedIn = false

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
