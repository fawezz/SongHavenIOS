//
//  SendOtpViewModel.swift
//  songHaven-IOS
//
//  Created by zewaff on 12/11/2022.
//
import SwiftUI
@MainActor class SendOtpViewModel: ObservableObject {
    
    @Published var navigator : String? = nil
    @Published var email = ""
    
    @Published var showSuccessToast : Bool = false
    @Published var showFailToast : Bool = false
    @Published var toastMessage = ""
    
    
    func sendOtp(){
        UserDefaults.standard.setValue(
            email , forKey: "email"
        )
        UserService.SendOtpMail(email: UserDefaults.standard.string(forKey: "email")!) { (success, reponse) in
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
        }
    }
    
    func validateFields()-> Bool{
        
        return self.isEmail(strToValidate: email)
    }
    
    func isEmail(strToValidate : String)-> Bool{
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})+$"  // 1

          let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)  // 2

          return emailValidationPredicate.evaluate(with: strToValidate)  // 3
    }
}
