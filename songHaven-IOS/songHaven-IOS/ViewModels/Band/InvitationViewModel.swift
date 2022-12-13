//
//  InvitationViewModel.swift
//  songHaven-IOS
//
//  Created by SongH on 13/12/2022.
//

import Foundation
@MainActor class InvitationViewModel: ObservableObject {
    @Published var navigator : String? = nil
    @Published var invitation = [Band]()
    
    init() {
        fetchInvitations()
    }
    
    private func fetchInvitations() {
        BandService.getByUser( completed: { (success, bandArray) in
            if(success){
                self.invitation = bandArray ?? []
            }
        })
    }
}

