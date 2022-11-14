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
                VStack(spacing:20) {
                    
                    Text("REGISTER")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    Image("logo")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .scaledToFit()
                    
                    
                    NavigationLink(destination: LoginView()){
                         
                        Button("Login into your existant account",action:{
                            print("yo")
                 
                        }
                        
                        )
                         .foregroundColor(.white)
                         .frame(width: 300, height: 50)
                         .background(Color.clear)
                         .cornerRadius(10)
                     }
                    
                    
                    
                  
                    
            //NavigationLink(destination: ResetPasswordView(), label: )
                    
                   
                    
                    TextField("Enter your name",text:$name)
               
                        .padding([.leading, .bottom, .trailing])
                        .background(Color.white.opacity(0.35))
                        .cornerRadius(10)
                        .foregroundColor(.white)
               
                    
                    TextField("Enter your lastname",text:$lastname)
                        .padding([.leading, .bottom, .trailing])
                 
                        .background(Color.white.opacity(0.35))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                   //     .shadow(color: .pink.opacity(0.08), radius: 60, x: 16, y: 16)
                    
                    TextField("Enter your Email",text:$email)
                        .padding([.leading, .bottom, .trailing])
                     
                        .background(Color.white.opacity(0.35))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    TextField("Password",text:$password)
                        .padding([.leading, .bottom, .trailing])
                        //.frame(width: 300, height :50)
                        .background(Color.white.opacity(0.35))
                    
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    TextField("Confirm your password",text:$confirmPassword)
                        .padding([.leading, .bottom, .trailing])
                
                        .background(Color.white.opacity(0.35))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    
                            NavigationLink(destination: HomeView()){
                                 
                                Button("Register",action:{
                                    print("yo")
                         
                                }
                                
                                )
                                 .foregroundColor(.white)
                                 .frame(width: 300, height: 50)
                                 .background(Color.green)
                                 .cornerRadius(10)
                             }
                }
                .padding(.all)
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

