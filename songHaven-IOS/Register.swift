//
//  LogIn.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 7/11/2022.
//

import SwiftUI

struct LogIn: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isArtist = false
    @State  private var ShowingLoginscrean = false
    
    
    
    var body: some View {
        NavigationView{
     
                    ZStack{  LinearGradient(gradient: .init(colors: [.pink , .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
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
                    TextField("Enter your name",text:$username)
                        .padding()
                        .frame(width: 300, height :50)
                        .background(Color.white.opacity(0.35))
                        .cornerRadius(10)
                    
                    TextField("Enter your email",text:$username)
                        .padding()
                        .frame(width: 300, height :50)
                        .background(Color.white.opacity(0.35))
                        .cornerRadius(10)
                    
                    
                    TextField("Enter your surname",text:$username)
                        .padding()
                        .frame(width: 300, height :50)
                        .background(Color.white.opacity(0.35))
                        .cornerRadius(10)
                    
                     
                    TextField("Password",text:$password)
                        .padding()
                        .frame(width: 300, height :50)
                        .background(Color.white.opacity(0.35))
                        .cornerRadius(10)
                    
                    TextField("Confirm your password",text:$username)
                        .padding()
                        .frame(width: 300, height :50)
                        .background(Color.white.opacity(0.35))
                        .cornerRadius(10)
                
                 
                    Toggle("Artiste",isOn:$isArtist)
                        .foregroundColor(.white)
                        .lineSpacing(2000
                    )
                    
                    
                    
                    Button("Submit"){
                      
                        
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.pink)
                    .cornerRadius(10)
               
                    NavigationLink (destination :Text(" You are logged in @\(username)"),isActive: $ShowingLoginscrean){
                        EmptyView()
                }
                   
            }
        }
            .navigationBarHidden(true)
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
}
