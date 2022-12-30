//
//  FBLoginButtonView.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 30/12/2022.
//

import SwiftUI
import FBSDKLoginKit
struct FBLoginButtonView: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<FBLoginButtonView>) -> FBLoginButton {
        let button = FBLoginButton()
        button.permissions = ["public_profile", "email"]
        button.delegate = context.coordinator
        return button
    }

    func updateUIView(_ uiView: FBLoginButton, context: UIViewRepresentableContext<FBLoginButtonView>) {
    }

    func makeCoordinator() -> FBLoginButtonView.Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, LoginButtonDelegate {
        var parent: FBLoginButtonView

        init(_ parent: FBLoginButtonView) {
            self.parent = parent
        }

        func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
            if let error = error {
                // An error occurred during the login flow. You can display an error message to the user or handle the error in some other way.
                print("Error: \(error.localizedDescription)")
            } else if let result = result, !result.isCancelled {
                // The login was successful. You can use the AccessToken object to make API requests on behalf of the user.
                let accessToken = result.token
                print("Access token: \(String(describing: accessToken?.tokenString))")
            }
        }
        
//        func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
//            // Handle the login result
//
////            switch result {
////                        case .success(grantedPermissions: _, declinedPermissions: _, token: _):
////                            // Login was successful
////                            print("Logged in!")
////                        case .failed(error: let error):
////                            // Login failed with error
////                            print("Error: \(error.localizedDescription)")
////                        case .cancelled:
////                            // Login was cancelled
////                            print("Login cancelled")
////                        }
////                    }, logoutHandler: {
////                        // Logout was successful
////                        print("Logged out!")
////                    })
//        }

        func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
            // Handle the logout event
        }
    }
}
