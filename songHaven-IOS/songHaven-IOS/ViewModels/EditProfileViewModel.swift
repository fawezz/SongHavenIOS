//
//  EditProfileView.swift
//  songHaven-IOS
//
//  Created by zewaff on 14/11/2022.
//

import SwiftUI
import _PhotosUI_SwiftUI

@MainActor class EditProfileViewModel: ObservableObject {
    
    @Published var firstname = UserDefaults.standard.string(forKey: "firstname")!
    @Published var lastname = UserDefaults.standard.string(forKey: "lastname")!
    //@Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    @Published var selectedItem: PhotosPickerItem? = nil
    @Published var selectedImageData: Data? = nil
    @Published var profileImageUrl: URL = URL(string: UserService.UserImageUrl + UserDefaults.standard.string(forKey: "imageId")!)!
    
    
    @Published var navigator: String? = nil
    @Published var isLoading: Bool = false
    @Published var isUploading: Bool = false
    
    @Published var showSuccessToast : Bool = false
    @Published var showFailToast : Bool = false
    @Published var toastMessage = ""
    
    
    func EditDetails(action: ()){
        isLoading = true
        UserService.EditDetails(id: UserDefaults.standard.string(forKey: "userId")!, firstname: firstname, lastname: lastname, password: password, completed: { (success, reponse) in
            
            self.isLoading = false
            if success {
                print("success")
                let currentUser = reponse as! User
                UserDefaults.standard.setValue(
                    currentUser.firstname,forKey: "firstname"
                )
                UserDefaults.standard.setValue(
                    currentUser.lastname,forKey: "lastname"
                )
                self.toastMessage = "Success"
                self.showSuccessToast = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2){
                    action//self.navigator = "Profile"
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
    
    func editImage(){
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
    
    func validateFields()-> Bool{
        //return true
        return (self.isLettersOnly(strToValidate: self.firstname) && self.isLettersOnly(strToValidate: self.lastname) && self.password.count >= 8 || self.password.count == 0 && self.password == self.confirmPassword )
    }
    
    func isEmail(strToValidate : String)-> Bool{
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})+$"  // 1
        
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)  // 2
        
        return emailValidationPredicate.evaluate(with: strToValidate)  // 3
    }
    
    func isLettersOnly(strToValidate : String)-> Bool{
        let emailValidationRegex = #"^([\p{L},.'’-]+(\s|$))+"#  // 1
        
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)  // 2
        
        return emailValidationPredicate.evaluate(with: strToValidate)  // 3
    }
    
    
}
