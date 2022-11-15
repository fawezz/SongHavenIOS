//
//  LoginViewModel.swift
//  songHaven-IOS
//
//  Created by zewaff on 12/11/2022.
//

import SwiftUI

@MainActor class LoginViewModel: ObservableObject {
    
    @Published var hiddenPass: Bool = false
    @Published var email = ""
    @Published var password = ""
    
    @Published var showSuccessToast : Bool = false
    @Published var showFailToast : Bool = false
    @Published var toastMessage = ""
    
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var navigator: String? = nil
    
    
    func Login(){
        isLoading = true
        UserService.SignIn(email: email, password: password, completed: { (success, reponse) in
            
            self.isLoading = false
            if success {
                print("success")
                let currentUser = reponse as! User
                if currentUser.isVerified! {
                    self.navigator = "Profile"
                    print("user Verified")
                } else {
                    print("user not Verified")
                    self.showAlert = true
                }
            } else {
                self.toastMessage = reponse as! String
                self.showFailToast = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2){
                    self.showFailToast = false
                }
                print("fail")
            }
        })
        
    }
    func ResendWelcomeMail(){
        let id = UserDefaults.standard.string(forKey: "userId")!
        let email = UserDefaults.standard.string(forKey: "email")!
        UserService.ResendWelcomeMail(id: id, email: email, completed:
                                        { (success, reponse) in
            self.toastMessage = reponse!
            if success {
                self.showSuccessToast = true
                print("success")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2){
                    self.navigator = "OtpVerification"
                    print("check ur mail")
                    self.showSuccessToast = false
                }
                
            } else {
                self.showFailToast = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    self.showFailToast = false
                }
                print(self.toastMessage)
            }
        })
    }
    func validateFields()-> Bool{
        return (self.isEmail(strToValidate: email) && password.count >= 8)
    }
    
    func isEmail(strToValidate : String)-> Bool{
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})+$"  // 1
        
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)  // 2
        
        return emailValidationPredicate.evaluate(with: strToValidate)  // 3
    }
}



