//
//  LoginView.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 11/11/2022.
//

import SwiftUI

struct LoginView: View {
    @State private var selection: String? = nil
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        NavigationView {
            
            VStack(alignment: .center) {
                Spacer()
                Text("Welcome To SongHaven")
                    .foregroundColor(Color.white)
                    .fontWeight(Font.Weight.bold)
                Spacer().frame(height: 50)
                VStack(alignment: .leading, spacing: 15) {
                    TextField("Email", text: self.$email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20.0)
                    SecureField("Password", text: self.$password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20.0)
                }.padding([.leading, .trailing], 27.5)
                Spacer().frame(height: 50)
                NavigationLink(destination: Text("Home View"), tag: "home", selection: $selection) { EmptyView() }
                NavigationLink(destination: ResetPasswordView(), tag: "forgotPass", selection: $selection) { EmptyView() }
                NavigationLink(destination: RegisterView(), tag: "SignUp", selection: $selection) { EmptyView() }
               
                VStack( alignment: .listRowSeparatorLeading){
                    Spacer().frame(width: 0, height: 36.0, alignment: .topLeading)
                    Button(action: {
                        self.selection = "forgotPass"
                    }) {
                        Text("Forgot Password ?")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.clear)
                            .cornerRadius(15.0)
                        
                    }}
                VStack{
                Button(action: {
                    self.selection = "home"
                }) {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.green)
                        .cornerRadius(15.0)
                }
                    
                    Button(action: {
                        self.selection = "SignUp"
                    }) {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.green)
                            .cornerRadius(15.0)
                    }
                    
                }
                
                
                
            }.background(
                LinearGradient(gradient: Gradient(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all))
            
        }.navigationTitle("Login")
    }
    
}
