//
//  BandsViewModel.swift
//  songHaven-IOS
//
//  Created by SongH on 23/11/2022.
//

import SwiftUI

@MainActor class BandsViewModel: ObservableObject {
    
    @Published var firstname = ""
    @Published var lastname = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
}


