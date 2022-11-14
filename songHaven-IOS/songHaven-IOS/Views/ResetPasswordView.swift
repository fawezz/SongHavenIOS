//
//  NewPassword.swift
//  songHaven-IOS
//
//  Created by Cyrine-Faouze on 7/11/2022.
//

import SwiftUI

struct ResetPasswordView: View {
    @ObservedObject var viewModel = ResetPasswordViewModel()
    
    
    var body: some View {
        NavigationView{
            ZStack{  LinearGradient(gradient: .init(colors: [.purple , .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                VStack  (spacing: 20){
                    
                    
                    Text("Create new password")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white                                                )
                    
                    Image("forgotPass3")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .cornerRadius(40)
                        .padding(.vertical, 10)
                    Text("Please enter your new password:")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white                                                )
                    SecureField("Enter new password",text:$viewModel.password)
                        .padding()
                        .frame(width: 300, height :50)
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    SecureField("Confirm Password",text:$viewModel.confirmPassword)
                        .padding()
                        .frame(width: 300, height :50)
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    Button("Reset password"){
                        viewModel.navigator = "LoginView"
                        
                    }
                    .disabled(!viewModel.verifyFields())
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(buttonColor)
                    .cornerRadius(10)
                    
                }
                NavigationLink(destination: LoginView(), tag: "LoginView", selection: $viewModel.navigator){}
                
            }
        }.navigationBarHidden(true)
    }
    var buttonColor: Color{
        if(!viewModel.verifyFields()){
            return Color.gray
        }else{
            return Color.green
        }
    }
}


struct ResetPassword_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
