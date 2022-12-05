//
//  BandDetailView.swift
//  songHaven-IOS
//
//  Created by SongH on 23/11/2022.
//

import SwiftUI
@MainActor class BandDetailViewModel : ObservableObject {

    @Published var navigator : String? = nil
    @Published var profileImageUrl: URL = URL(string: BandService.BandImageUrl + UserDefaults.standard.string(forKey: "imageId")!)!
    let name : String = UserDefaults.standard.string(forKey: "name") ?? ""
    let discription : String = UserDefaults.standard.string(forKey: "discription") ?? ""
}

