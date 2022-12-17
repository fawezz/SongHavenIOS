//
//  UserAuthModel.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 9/12/2022.
//

import Foundation
import GoogleSignIn

class GoogleAuthService: ObservableObject {
    
    @Published var firstname: String = ""
    @Published var lastname: String = ""
    @Published var profilePicUrl: String = ""
    @Published var email:String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    
    static let shared: GoogleAuthService = {
        let instance = GoogleAuthService()
        return instance
    }()
    
    init(){
        check()
    }
    
    func checkStatus(){
        print("inside check status")

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

        let signInConfig = GIDConfiguration.init(clientID: "717300153408-gealid8op270o73bf51u2kvi7gg2kiq2.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(
            with: signInConfig,
            presenting: presentingViewController,
            callback: { user, error in
                if let error = error {
                    self.errorMessage = "error: \(error.localizedDescription)"
                    completed(false)
                    print("inside signin error")

                }
                self.checkStatus()
                completed(true)
            }
        )
    }
    
    func signOut(){
        GIDSignIn.sharedInstance.signOut()
        self.checkStatus()
    }
}
