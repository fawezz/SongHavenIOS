//
//  RegisterViewModel.swift
//  songHaven-IOS
//
//  Created by zewaff on 13/11/2022.
//
import SwiftUI

@MainActor class RegisterViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var lastname = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    @Published var navigator: String? = nil
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var hiddenPass: Bool = false

    
    func test(){
        print("aaaaaaaaa" + email + password)
    }
    
    func validateFields()-> Bool{
        
        return (email.count > 4 && password.count >= 8)
    }
}

