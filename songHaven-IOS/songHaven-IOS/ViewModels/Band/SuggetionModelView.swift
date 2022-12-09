//
//  SuggetionModelView.swift
//  songHaven-IOS
//
//  Created by SongH on 6/12/2022.
//

import Foundation
@MainActor class ArtistSuggetionViewModel: ObservableObject {
   
        @Published var searchedUsers = [User]()
        @Published var searchText : String
        @Published var isLoading = true
        
        init( searchText: String) {
            self.searchText = searchText
        
            searchUsers()
        }
        
        func searchUsers() {
            UserService.SearchUsers( searchText: self.searchText, completed: {(success, usersArray) in
                if(success){
                    self.searchedUsers = usersArray
                    self.isLoading = false
                }else{
                    self.isLoading = false
                }
            })
        }
            
    //
    //    func isDataReceived() -> Bool{
    //
    //        return !self.searchedSongs.isEmpty
    //    }
    }

