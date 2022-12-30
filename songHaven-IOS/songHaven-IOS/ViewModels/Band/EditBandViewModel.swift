//
//  EditBandViewModel.swift
//  songHaven-IOS
//
//  Created by SongH on 10/12/2022.
//

import Foundation
@MainActor class EditBandViewModel: ObservableObject {
    @Published var name = ""
    @Published var discription = ""
    @Published var image = ""
    
    @Published var selectedImageData: Data? = nil
    // @Published var bandImageUrl: URL = (URL(string: BandService.BandImageUrl + UserDefaults.standard.string(forKey: "image")!) ?? "image")
    
    @Published var navigator: String? = nil
    @Published var isLoading: Bool = false
    @Published var isUploading: Bool = false
    
    @Published var showSuccessToast : Bool = false
    @Published var showFailToast : Bool = false
    @Published var toastMessage = ""
    
    
    func EditDetails(){
        isLoading = true
        BandService.EditBand(id: UserDefaults.standard.string(forKey: "bandId")!, name: name, discription: discription, image: image, completed: { (success, reponse) in
            
            self.isLoading = false
            if success {
                print("success")
                let currentBand = reponse as! Band
                UserDefaults.standard.setValue(
                    currentBand.name,forKey: "name"
                )
                UserDefaults.standard.setValue(
                    currentBand.discription,forKey: "discription"
                )
                UserDefaults.standard.setValue(
                    currentBand.image,forKey: "image"
                )
                self.toastMessage = "Success"
                self.showSuccessToast = true
                //                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2){
                //                    action//self.navigator = "Profile"
                //                    self.showSuccessToast = false
                //                }
            }
            else {
                self.toastMessage = reponse as! String
                self.showFailToast = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2){
                    self.showFailToast = false
                }
                print("fail")
            }
        })
    }
}
