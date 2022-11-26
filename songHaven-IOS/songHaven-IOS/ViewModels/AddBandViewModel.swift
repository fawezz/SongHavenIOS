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
    @Published var discriptopn = ""
    @Published var isUploading: Bool = false
    @Published var selectedImageData: Data? = nil
    //  @Published var bandImageUrl : URL = URL(string: BandService.Band)
    @Published var profileImageUrl: URL = URL(string: UserService.UserImageUrl + UserDefaults.standard.string(forKey: "imageId")!)!
    @Published var toastMessage = ""
    @Published var showSuccessToast : Bool = false
    @Published var showFailToast : Bool = false
    
    
    
    
    
    
    
    
    
    func EditImage(){
         self.isUploading = true
         UserService.uploadImage(email: UserDefaults.standard.string(forKey: "email")!, image: UIImage(data: selectedImageData!), completed: { (success, reponse) in
         
         self.isUploading = false
         if success {
         print("success edit image")
         self.profileImageUrl = URL(string: UserService.UserImageUrl + UserDefaults.standard.string(forKey: "imageId")!)!
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
         
        
        
    }
    

