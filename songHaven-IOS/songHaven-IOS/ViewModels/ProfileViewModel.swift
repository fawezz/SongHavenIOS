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
    @Published var profileImageUrl: URL = URL(string: UserService.UserImageUrl + UserDefaults.standard.string(forKey: "imageId")!)!
    let firstname : String = UserDefaults.standard.string(forKey: "firstname")!
    let lastname : String = UserDefaults.standard.string(forKey: "lastname")!
    
    
    func Logout(){
        UserDefaults.standard.setValue(
            nil,forKey: "token"
        )
        UserDefaults.standard.setValue(
            nil,forKey: "email"
        )
        UserDefaults.standard.setValue(
            nil,forKey: "userId"
        )
     }
    
    
}
