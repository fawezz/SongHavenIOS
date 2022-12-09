//
//  ResetPasswordViewModel.swift
//  songHaven-IOS
//
//  Created by zewaff on 12/11/2022.
//
import SwiftUI

@MainActor class ResetPasswordViewModel: ObservableObject {
    
    @Published var navigator : String? = nil
    @Published var hiddenPass: Bool = false
    @Published var password = ""
    @Published var confirmPassword = ""
    
    @Published var showSuccessToast : Bool = false
    @Published var showFailToast : Bool = false
    @Published var toastMessage = ""
    
    
    func verifyFields()->Bool{
        return password.count >= 8 && confirmPassword == password
    }
    
    func changePassword(action: ()){
        UserService.CreateNewPassword(email: UserDefaults.standard.string(forKey: "email")!, password: self.password) { (success, reponse) in
            self.toastMessage = reponse!
            if success {
                self.showSuccessToast = true
                print("success password changed")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2){
                    action //self.navigator = "LoginView"
                    self.showSuccessToast = false
                }
            } else {
                self.showFailToast = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    self.showFailToast = false
                }
                print(self.toastMessage)
                
            }
        }
    }
}
