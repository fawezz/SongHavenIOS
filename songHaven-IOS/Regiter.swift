//
//  Regiter.swift
//  songHaven-IOS
//
//  Created by Cyrine-Faouze on 7/11/2022.
//

import SwiftUI

struct Redister : View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPasssword = 0
    @State private var ShowingLoginscrean = false
    
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.purple
                    .ignoresSafeArea()
            Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
        Circle()
                    .scale(1.35)
                    .foregroundColor(.white)
                VStack {
                    Image ("")
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .frame(width : 80, height :80 )
                    
                    Text("Song Haven")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    TextField("Username",text:$username)
                        .padding()
                        .frame(width: 300, height :50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUsername))
                    
                    TextField("Password",text:$password)
                        .padding()
                        .frame(width: 300, height :50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPasssword))
                   
                
                    Button("Login"){
                        AuthentificateUser(username: username, password: password)
                        
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.pink)
                    .cornerRadius(10)
                    te
                    
                    NavigationLink (destination :Text(" You are logged in @\(username)"),isActive: $ShowingLoginscrean){
                        EmptyView()
                }
                
            }
        }
            .navigationBarHidden(true)
    }
}
    
    }

    
    
    

struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LogIn()
            LogIn()
        }
    }
}

