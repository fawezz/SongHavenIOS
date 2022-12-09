//
//  UserSession.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 9/12/2022.
//

import Foundation
final class UserSession: ObservableObject {
    @Published var isSignedIn = false
    @Published var currentUser : User? = nil
    
    static let shared: UserSession = {
        let instance = UserSession()
        return instance
    }()
    
    init() {
        let token = UserDefaults.standard.string(forKey: "token")
        self.isSignedIn = token != "" && token != nil
    }
    
    func isAlreadySignedIn() {
        if(UserSession.shared.isSignedIn){
            let userId = UserDefaults.standard.string(forKey: "userId")
            UserService.GetById(userId: userId!, completed: { (success, reponse) in
                if success {
                    UserSession.shared.currentUser = reponse!
                } else {
                    print("error getting current user")
                }
            })
        }
    }
    
}
