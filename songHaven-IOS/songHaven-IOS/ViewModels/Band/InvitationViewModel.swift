//
//  InvitationViewModel.swift
//  songHaven-IOS
//
//  Created by SongH on 13/12/2022.
//

import Foundation
@MainActor class InvitationViewModel: ObservableObject {
    @Published var navigator : String? = nil
    @Published var invitation = [Invitation]()
    
    init() {
        fetchInvitations()
    }
    
    private func fetchInvitations() {
        InvitationService.getByUser( completed: { (success, bandArray) in
            if(success){
                self.invitation = bandArray ?? []
            }
        })
    }
}

