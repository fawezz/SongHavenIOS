//
//  UserBandsViewModel.swift
//  songHaven-IOS
//
//  Created by SongH on 5/12/2022.
//

import Foundation
@MainActor class UserBandsViewModel: ObservableObject {
    @Published var navigator : String? = nil
    @Published var userBands = [Band]()
    @Published var searchText : String = ""
    
    init() {
        fetchUserBands()
    }
    
    func fetchUserBands() {
        BandService.getByUser( completed: { (success, bandArray) in
            if(success){
                self.userBands = bandArray ?? []
            }
        })
    }
}
