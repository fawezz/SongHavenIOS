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
    
    
    
    func verifyFields()->Bool{
        return password.count >= 8 && confirmPassword == password
    }
    
    
}
