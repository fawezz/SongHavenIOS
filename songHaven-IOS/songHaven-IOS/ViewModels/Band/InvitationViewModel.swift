//
//  InvitationViewModel.swift
//  songHaven-IOS
//
//  Created by SongH on 13/12/2022.
//

import Foundation
@MainActor class InvitationViewModel: ObservableObject {
    @Published var navigator : String? = nil
    @Published var invitations = [Invitation]()
    
    @Published var showSuccessToast : Bool = false
    @Published var showFailToast : Bool = false
    @Published var toastMessage = ""
    
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var toastText: String = ""

    
    init() {
        fetchInvitations()
    }
    
  func fetchInvitations() {
        InvitationService.getByUser( completed: {
            (success, invitationArray) in
            if(success){
                self.invitations = invitationArray ?? []
            }
        })
    }
    
                                         
    func acceptInvitation(invitation :Invitation) {
        InvitationService.acceptInvitation(userId:(invitation.recipient?._id)! , bandId: (invitation.requester?._id)!, completed: { (success, reponse) in
                self.isLoading = false
                if success {
                    self.toastText = "You belong to  this band"
                    self.showSuccessToast = true
                    print("success")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2){
                        self.navigator = "accept"
                        print("You belong to  this band")
                        self.showSuccessToast = false
                    }
                } else {
                    self.toastText = "accept failed"
                    self.showFailToast = true
                    print("failure")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                        self.showFailToast = false
                    }
                }
            })
        }
                
      
  func declineInviation(invitation :Invitation) {
      InvitationService.declineInvitation(invitationId: invitation._id!,  completed: {
                 (success, reponse) in
                    self.isLoading = false
                    if success {
                        self.toastText = "Invitation rejected"
                        self.showSuccessToast = true
                        print("success")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2){
                            self.navigator = "declineInv"
                            print("Invitation rejected")
                            self.showSuccessToast = false
                        }
                    } else {
                        self.toastText = "decline failed"
                        self.showFailToast = true
                        print("failure")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            self.showFailToast = false
                        }
                    }
                })
            }
                    
               
                                                    
                                                    
 }
                                                    
                                                   
