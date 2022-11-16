//
//  RegisterViewModel.swift
//  songHaven-IOS
//
//  Created by zewaff on 13/11/2022.
//
import SwiftUI

@MainActor class RegisterViewModel: ObservableObject {
    
    @Published var firstname = ""
    @Published var lastname = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    @Published var navigator: String? = nil
    @Published var isLoading: Bool = false
    @Published var hiddenPass: Bool = false
    
    @Published var showSuccessToast: Bool = false
    @Published var showFailToast: Bool = false
    @Published var toastText: String = ""
    
    
    func register(){
        isLoading = true
        UserService.SignUp(email: email, password: password, firstName: firstname, lastName: lastname, completed: { (success, reponse) in
            
            self.isLoading = false
            if success {
                self.toastText = "Check Your Email"
                self.showSuccessToast = true
                print("success")
                //let currentUser = reponse as! User
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2){
                    self.navigator = "Login"
                    print("check ur mail")
                    self.showSuccessToast = false
                }
            } else {
                self.toastText = reponse as! String
                self.showFailToast = true
                print("failure")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    self.showFailToast = false
                }
            }
        })
    }
    
    func validateFields()-> Bool{
        //return true
        return (self.isEmail(strToValidate: email) && self.password.count >= 8 && self.password == self.confirmPassword && self.isLettersOnly(strToValidate: firstname) && self.isLettersOnly(strToValidate: lastname) )
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

