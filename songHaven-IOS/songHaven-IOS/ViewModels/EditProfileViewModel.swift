//
//  EditProfileView.swift
//  songHaven-IOS
//
//  Created by zewaff on 14/11/2022.
//

import SwiftUI
import _PhotosUI_SwiftUI

@MainActor class EditProfileViewModel: ObservableObject {
    
    @Published var firstname = ""
    @Published var lastname = ""
    //@Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    @Published var selectedItems: [PhotosPickerItem] = []
    
    @Published var navigator: String? = nil
    @Published var isLoading: Bool = false
    
    @Published var showSuccessToast : Bool = false
    @Published var showFailToast : Bool = false
    @Published var toastMessage = ""
    
    
    func EditDetails(){
        isLoading = true
        UserService.EditDetails(id: "6373c3575a4f51eb3fbbe7b1", firstname: firstname, lastname: lastname, password: password, completed: { (success, reponse) in
            
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
    
    func validateFields()-> Bool{
        return true
        return (self.isLettersOnly(strToValidate: self.firstname) && self.isLettersOnly(strToValidate: self.lastname) && self.password.count >= 8 && self.password == self.confirmPassword )
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
