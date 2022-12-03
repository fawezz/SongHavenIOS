//
//  AddBandViewModel.swift
//  songHaven-IOS
//
//  Created by SongH on 25/11/2022.
//

import SwiftUI
import _PhotosUI_SwiftUI
@MainActor class AddBandViewModel: ObservableObject {
    @Published var name = ""
    @Published var discription = ""
    @Published var isUploading: Bool = false
    @Published var isLoading: Bool = false
    @Published var selectedImageData: Data? = nil
    @Published var navigator : String? = nil
    @Published var bandImageUrl: URL = URL(string: BandService.BandImageUrl + UserDefaults.standard.string(forKey: "imageId")!)!
    @Published var uplodedImg : UIImage = UIImage()
    @Published var toastMessage = ""
    @Published var showSuccessToast : Bool = false
    @Published var showFailToast : Bool = false
    @Published var selectedItem: PhotosPickerItem? = nil
    
    
    
    func AddImage(){
         self.isUploading = true
        BandService.uploadImage(name: UserDefaults.standard.string(forKey: "name") ?? "name", image: UIImage(data: selectedImageData!), completed: { (success, reponse) in
         
         self.isUploading = false
         if success {
         print("success add image")
             self.bandImageUrl = URL(string: BandService.BandImageUrl + UserDefaults.standard.string(forKey: "imageId")!)!
         self.toastMessage = reponse
         self.showSuccessToast = true
         DispatchQueue.main.asyncAfter(deadline: .now() + 1){
         self.showSuccessToast = false
         }
         }
         else {
         self.toastMessage = reponse
         self.showFailToast = true
         DispatchQueue.main.asyncAfter(deadline: .now() + 1){
         self.showFailToast = false
         }
         print("fail edit")
         }
         })
         
         
         }
         
    func createBand(){
        isLoading = true
        BandService.create(name: name, discription: discription, imageId: "" , completed: { (success, reponse) in
            
            self.isLoading = false
            if success {
                self.showSuccessToast = true
                print("success")
                //let currentUser = reponse as! User
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2){
                    print("check ur mail")
                    self.showSuccessToast = false
                }
            } else {
                self.toastMessage = reponse as! String
                self.showFailToast = true
                print("failure")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    self.showFailToast = false
                }
            }
        })
    }
        
    }
    

