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
    
    
    
    func verifyFields()->Bool{
        return email.count > 5
    }
    
    func sendOtp(){
        UserDefaults.standard.setValue(
            self.email, forKey: "email"
        )
    }
    
}
