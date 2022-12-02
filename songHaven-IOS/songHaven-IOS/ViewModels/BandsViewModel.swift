//
//  BandsViewModel.swift
//  songHaven-IOS
//
//  Created by SongH on 23/11/2022.
//

import SwiftUI

@MainActor class BandsViewModel: ObservableObject {
    
    @Published var newBands = [ Band] ()
    @Published var searchText : String = ""
    @Published var bandImageUrl: URL = URL(string:BandService.BandImageUrl + UserDefaults.standard.string(forKey: "imageId")!)!
    
    
    init (){
        
        fetchNewBands()
    }
    
    private func fetchNewBands(){
        
        BandService.GetAllBands(completed:{(success , bandArray) in
            if( success){
                self.newBands = bandArray ?? []
                
            }
        })
    }
    
    
}
