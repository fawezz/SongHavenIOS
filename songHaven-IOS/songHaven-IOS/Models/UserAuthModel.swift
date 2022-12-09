//
//  UserAuthModel.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 9/12/2022.
//

import Foundation
import GoogleSignIn

class UserAuthModel: ObservableObject {
    
    @Published var firstname: String = ""
    @Published var lastname: String = ""
    @Published var profilePicUrl: String = ""
    @Published var email:String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    
    init(){
        check()
    }
    
    func checkStatus(){
        if(GIDSignIn.sharedInstance.currentUser != nil){
            let user = GIDSignIn.sharedInstance.currentUser
            guard let user = user else { return }
            let firstname = user.profile?.givenName
            let lastname = user.profile?.familyName
            let profilePicUrl = user.profile!.imageURL(withDimension: 100)!.absoluteString
            let email =   user.profile?.email
            self.email = email ?? ""
            self.firstname = firstname ?? ""
            self.lastname = lastname ?? ""
            self.profilePicUrl = profilePicUrl
            self.isLoggedIn = true
        }else{
            self.isLoggedIn = false
            self.firstname = ""
            self.lastname = ""
            self.profilePicUrl =  ""
            self.email = ""

        }
    }
    
    func check(){
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error = error {
                self.errorMessage = "error: \(error.localizedDescription)"
            }
            
            self.checkStatus()
        }
    }
    
    func signIn(completed: @escaping (Bool)->Void){
        
       guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}

        let signInConfig = GIDConfiguration.init(clientID: "181555315393-46gdqmd4bcffdq2tg9ge184s5qhgmlev.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(
            with: signInConfig,
            presenting: presentingViewController,
            callback: { user, error in
                if let error = error {
                    self.errorMessage = "error: \(error.localizedDescription)"
                    completed(false)

                }
                completed(true)
                self.checkStatus()
            }
        )
    }
    
    func signOut(){
        GIDSignIn.sharedInstance.signOut()
        self.checkStatus()
    }
}
