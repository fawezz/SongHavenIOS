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
                    Text("REGISTER")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                    
                    
                    Button("Login in to your existant account"){
                        
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.clear)
                    .cornerRadius(10)
            //NavigationLink(destination: ResetPasswordView(), label: )
                    
                   
                    
                    TextField("Enter your name",text:$name)
               
                        .padding()
                        .background(Color.white.opacity(0.35))
                        .cornerRadius(90)
                        .foregroundColor(.white)
               
                    
                    TextField("Enter your lastname",text:$lastname)
                        .padding()
                 
                        .background(Color.white.opacity(0.35))
                        .cornerRadius(90)
                        .foregroundColor(.white)
                   //     .shadow(color: .pink.opacity(0.08), radius: 60, x: 16, y: 16)
                    
                    TextField("Enter your Email",text:$email)
                        .padding()
                     
                        .background(Color.white.opacity(0.35))
                        .cornerRadius(30)
                        .foregroundColor(.white)
                    
                    TextField("Password",text:$password)
                        .padding()
                        //.frame(width: 300, height :50)
                        .background(Color.white.opacity(0.35))
                        .cornerRadius(90)
                        .foregroundColor(.white)
                    
                    TextField("Confirm your password",text:$confirmPassword)
                        .padding()
                
                        .background(Color.white.opacity(0.35))
                        .cornerRadius(90)
                        .foregroundColor(.white)
                    /*
                    
                    Button( action: {
                        print("Upload your profile image")
                        
                    }){ Image ("logo")
                            .renderingMode(Image.TemplateRenderingMode? .init(Image.TemplateRenderingMode.original))
                    }
                       */
                    
                   
                    
                    
                    Button("Submit"){
                        
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.green)
                    .cornerRadius(30)
                    
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

