//
//  ContentView.swift
//  SongHaven
//
//  Created by fawez on 7/11/2022.
//

import SwiftUI
import CoreData

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
                NavigationLink(destination: Text("Forgot password"), tag: "forgotPass", selection: $selection) { EmptyView() }
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
                Spacer()
            }.background(
                LinearGradient(gradient: Gradient(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all))
        }.navigationTitle("Login")
    }
}

