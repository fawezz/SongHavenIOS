//
//  ForgotPasswordViewModel.swift
//  songHaven-IOS
//
//  Created by zewaff on 12/11/2022.
//
import SwiftUI

@MainActor class ForgotPasswordViewModel: ObservableObject {

    @Published var navigator : String? = nil
    @Published var hiddenPass: Bool = false
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    
    
    func ReceiveMail(){
        print("test" + email + password + confirmPassword)
    }
}
