//
//  VerificqtionCodeViewModel.swift
//  songHaven-IOS
//
//  Created by zewaff on 12/11/2022.
//
import SwiftUI

@MainActor class OtpVerificationViewModel: ObservableObject {
    
    @Published var navigator : String? = nil

    @Published var borderColor: Color = .black
    @Published var isTextFieldDisabled = false
    @Published var showToast = false
    @Published var isLoading = false
    @Published var showAlert = false
    
    @Published var otpField = "" {
        didSet {
            guard otpField.count <= 5,
                  otpField.last?.isNumber ?? true else {
                otpField = oldValue
                return
            }
        }
    }
    var otp1: String {
        guard otpField.count >= 1 else {
            return ""
        }
        return String(Array(otpField)[0])
    }
    var otp2: String {
        guard otpField.count >= 2 else {
            return ""
        }
        return String(Array(otpField)[1])
    }
    var otp3: String {
        guard otpField.count >= 3 else {
            return ""
        }
        return String(Array(otpField)[2])
    }
    var otp4: String {
        guard otpField.count >= 4 else {
            return ""
        }
        return String(Array(otpField)[3])
    }
    
    var otp5: String {
        guard otpField.count >= 5 else {
            return ""
        }
        return String(Array(otpField)[4])
    }
    
    func ResendCode(){
        let model = SendOtpViewModel()
        model.email = UserDefaults.standard.string(forKey: "email")!
        model.sendOtp()
        self.showToast = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.showToast = false
        }
    }
    
    func VerifyOtp(){
        self.isLoading = true
        UserService.VerifyOtp(email: UserDefaults.standard.string(forKey: "email")!, otpCode: otpField, completed: { (success, reponse) in
            
            self.isLoading = false
            if success {
                print("success")
                let isAccepted = reponse ?? Optional(false)
                
                if isAccepted! {
                    self.navigator = "ResetPassword"
                    print("otp Accepted")
                } else {
                    self.showAlert = true
                    self.otpField.removeAll()
                    print("otp Refused")
                }
            } else {
                print("fail")
            }
        })
    }
    
    
    
}
