//
//  SuggetionModelView.swift
//  songHaven-IOS
//
//  Created by SongH on 6/12/2022.
//

import Foundation
@MainActor class ArtistSuggetionViewModel: ObservableObject {
    @Published var searchedUsers = [User]()
    @Published var searchText : String = ""
    @Published var isLoading = true
    @Published var selectedUser : User? = nil
    @Published var selectedBand : Band
    @Published var navigator : String? = nil
    
    
    init( band : Band) {
        self.selectedBand = band
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
    
    
    func userExists(artistList: [User]) -> Bool{
        return artistList.contains(self.selectedUser!)
    }
    
    func addArtistToBand( selectedUser: User) -> Bool {
        if((selectedBand.users?.contains(selectedUser)).unsafelyUnwrapped){
            
            BandService.RemoveArtist( userId: selectedUser._id!,
                                      completed:
                                        { (success, reponse) in
                if(success){
                    print("user removed successfully")
                }
            })
            
            return false
        }else{
            BandService.AddUser( userId: selectedUser._id!, completed:
                                    { (success, reponse) in
                if(success){
                    print("user added successfully")
                }
            })
        }
        
        return true
    }
    
}



