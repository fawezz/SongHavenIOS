//
//  BandDetailView.swift
//  songHaven-IOS
//
//  Created by SongH on 23/11/2022.
//
import Foundation
@MainActor class BandDetailViewModel : ObservableObject {
    @Published var selectedBand : Band
    @Published var BandMember : [User] = []

    @Published var navigator : String? = nil
    @Published var showAlert = false
    
    init(selectedBand: Band){
        
        self.selectedBand = selectedBand
    }
    
    func deleteBand(action: ()){
        BandService.DeleteBand(bandId: selectedBand._id!, completed:
            { (success, reponse) in
            if(success){
                action
            }
        })
    }
    
    func fetchBandMembers(){
        SongService.GetByCurrentUser( completed: {
            (success, reponse) in
            //self.userSongs = reponse
            print("received members")
            
        })
    }
    
}
  
