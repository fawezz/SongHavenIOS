//
//  LogIn.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 7/11/2022.
//

import SwiftUI

struct RegisterView: View {
    @State private var name = ""
    @State private var lastname = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State  private var ShowingLoginscrean = false
    
    
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: .init(colors: [.purple , .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                VStack {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                    
                    Text("Song Haven")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                    
                    TextField("Enter your name",text:$name)
                        .padding()
                        .frame(width: 300, height :50)
                        .background(Color.white.opacity(0.35))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    TextField("Enter your lastname",text:$lastname)
                        .padding()
                        .frame(width: 300, height :50)
                        .background(Color.white.opacity(0.35))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    TextField("Enter your Email",text:$email)
                        .padding()
                        .frame(width: 300, height :50)
                        .background(Color.white.opacity(0.35))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    TextField("Password",text:$password)
                        .padding()
                        .frame(width: 300, height :50)
                        .background(Color.white.opacity(0.35))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    TextField("Confirm your password",text:$confirmPassword)
                        .padding()
                        .frame(width: 300, height :50)
                        .background(Color.white.opacity(0.35))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    Button("Submit"){
                        
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.pink)
                    .cornerRadius(10)
                    
                    NavigationLink (destination :Text(" You are logged in @\(email)"),isActive: $ShowingLoginscrean){
                        EmptyView()
                    }
                    
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    
    struct Register_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                RegisterView()
            }
        }
    }
}

