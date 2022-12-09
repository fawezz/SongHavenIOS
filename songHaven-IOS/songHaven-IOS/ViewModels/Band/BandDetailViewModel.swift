//
//  BandDetailView.swift
//  songHaven-IOS
//
//  Created by SongH on 23/11/2022.
//
import Foundation
@MainActor class BandDetailViewModel : ObservableObject {
    
    @Published var selectedBand : Band
    @Published var navigator : String? = nil
    @Published var showAlert = false

//    @Published var profileImageUrl: URL = URL(string: BandService.BandImageUrl + UserDefaults.standard.string(forKey: "imageId")!)!
//    let name : String = UserDefaults.standard.string(forKey: "name") ?? ""
//    let discription : String = UserDefaults.standard.string(forKey: "discription") ?? ""
    
    init(selectedBand: Band){
        self.selectedBand = selectedBand
    }
    
    func deleteBnad(action: ()){
        BandService.DeleteBand(bandId: selectedBand._id!, completed: 
        { (success, reponse) in
               if(success){
                   action
               }
           })
       }
}

