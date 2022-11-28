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
    @Published var isLoading: Bool = false
    @Published var selectedImageData: Data? = nil
    //  @Published var bandImageUrl : URL = URL(string: BandService.Band)
    @Published var profileImageUrl: URL = URL(string: UserService.UserImageUrl + UserDefaults.standard.string(forKey: "imageId")!)!
    @Published var toastMessage = ""
    @Published var showSuccessToast : Bool = false
    @Published var showFailToast : Bool = false
    
    
    
    func Addband(){
        isLoading = true
        UserService.Edi(id: UserDefaults.standard.string(forKey: "bandId")!, firstname: firstname, lastname: lastname, password: password, completed: { (success, reponse) in
            
            self.isLoading = false
            if success {
                print("success")
                let currentUser = reponse as! User
                self.toastMessage = "Success"
                self.showSuccessToast = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2){
                    self.navigator = "Profile"
                    self.showSuccessToast = false
                }
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
    

