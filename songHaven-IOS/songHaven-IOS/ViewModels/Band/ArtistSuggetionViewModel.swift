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
    @Published var toastText : String = ""
    @Published var isLoading = true
    @Published var selectedUser : User? = nil
    @Published var selectedBand : Band
    @Published var navigator : String? = nil
    @Published var showSuccessToast : Bool = false
    @Published var showFailToast : Bool = false
 
  
    
    
    init( band : Band , selectedUser: User? = nil) {
        self.selectedBand = band
        searchUsers()
        
        self.selectedUser = selectedUser
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
    
    
    func sendInvitation(user :User) {
        InvitationService.SendInvitation(userId: user._id! , bandId: selectedBand._id! , completed: { (success, reponse) in
            self.isLoading = false
            if success {
                self.toastText = "invitation sent  successfully"
                self.showSuccessToast = true
                print("success")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2){
                    self.navigator = "sendInv"
                    print("invitation sent  successfully")
                    self.showSuccessToast = false
                }
            } else {
                self.toastText = reponse as! String
                self.showFailToast = true
                print("failure")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    self.showFailToast = false
                }
            }
        })
    }
    
//    func addArtistToBand( selectedUser: User) -> Bool {
//        if((selectedBand.users?.contains(selectedUser)).unsafelyUnwrapped){
//
//            BandService.RemoveArtist( userId: selectedUser._id!, bandId: self.selectedBand._id!,
//                                      completed:
//                                        { (success, reponse) in
//                if(success){
//                    print("user removed successfully")
//                }
//            })
//
//            return false
//        }else{
//            BandService.AddUser( userId: selectedUser._id!, completed:
//                                    { (success, reponse) in
//                if(success){
//                    print("user added successfully")
//                }
//            })
//        }
//
//        return true
//    }
    
}



