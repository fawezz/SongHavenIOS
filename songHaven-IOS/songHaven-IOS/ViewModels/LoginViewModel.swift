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
    
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var navigator: String? = nil
    
    func test(){
        print("aaaaaaaaa" + email + password)
    }
    
    func validateFields()-> Bool{
        
        return (email.count > 4 && password.count >= 8)
    }
    
    func Login(){
        isLoading = true
        UserService.SignIn(email: "faouez.marzouk@esprit.tn", password: "12345678", completed: { (success, reponse) in
            
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
                    /*
                    let action = UIAlertAction(title: "Réenvoyer", style: .default) { UIAlertAction in
                        self.reEnvoyerEmail(email: currentUser.email)
                    }
                    self.present(Alert.makeActionAlert(titre: "Notice", message: "This email is not confirmed, would you like to resend the confirmation email to " + currentUser.email! + " ?", action: action),animated: true)
                    self.reEnvoyerEmail(email: currentUser.email)
                     */
                }
            } else {
                print("fail")
//                self.present(Alert.makeAlert(titre: "Warning", message: "Email or password incorrect"), animated: true)
            }
        })
        
    }
    func sendConfirmationMail(){}
}



