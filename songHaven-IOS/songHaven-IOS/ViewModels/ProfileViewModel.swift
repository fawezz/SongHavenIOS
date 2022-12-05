//
//  ProfileViewModel.swift
//  songHaven-IOS
//
//  Created by zewaff on 12/11/2022.
//
import SwiftUI
@MainActor class ProfileViewModel: ObservableObject {

    @Published var navigator : String? = nil
    @Published var profileImageUrl: URL = URL(string: UserService.UserImageUrl + UserDefaults.standard.string(forKey: "imageId")!)!
    let firstname : String = UserDefaults.standard.string(forKey: "firstname")!
    let lastname : String = UserDefaults.standard.string(forKey: "lastname")!   
}
