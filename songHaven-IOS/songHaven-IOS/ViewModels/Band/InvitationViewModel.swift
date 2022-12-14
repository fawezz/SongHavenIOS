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
        InvitationService.getByUser( completed: {
            (success, invitationArray) in
            if(success){
                self.invitation = invitationArray ?? []
            }
        })
    }
    
    private func sendInitation() {
    //    InvitationService.SendInvitation(userId: <#T##String#>, bandId: <#T##String#>, completed: <#T##(Bool, Any?) -> Void#>)
        
            }
    
    private func acceptInvitation() {
      //  InvitationService.acceptInvitation(userId: <#T##String#>, bandId: <#T##String#>, completed: <#T##(Bool, Invitation?) -> Void#>)
   
            }
    private func declineInitation() {
      //  InvitationService.declineInvitation(userId: <#T##String#>, bandId: <#T##String#>, completed: <#T##(Bool, Invitation?) -> Void#>)
        
            }
    
    
}

