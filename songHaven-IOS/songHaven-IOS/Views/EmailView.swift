//
//  EmailView.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 12/11/2022.
//

import SwiftUI

struct EmailView: View {
    @State private var email = ""
    var body: some View {
    
        NavigationView{
         ZStack{  LinearGradient(gradient: .init(colors: [.purple , .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
             VStack  (spacing: 50){
                 
                 Image("padlock")
                     .resizable()
                 // .clipShape(Circle())
                     .scaledToFit()
                 //   .overlay(Circle().stroke(Color.white, lineWidth: 0.36))
                     .shadow(radius: 10)
                     .frame(width: 100,height: 100)
                 
                 Text("Forgot Password ?")
                     .font(.largeTitle)
                     .bold()
                     .foregroundColor(.white                                                )
                     .padding()
                 Text("Please enter your email address to recive a virification code ")
                     .font(.system(size: 16))
                     .foregroundColor(.white)
                     .multilineTextAlignment(.center)
                 
                 
                 TextField("Enter your email address",text:$email)
                     .frame(width: 300, height :50)
                     .foregroundColor(.white)
                     .background(Color.white.opacity(0.35))
                     .cornerRadius(10)
                 
                 
            
                    NavigationLink(destination: VerificationCodeView()){
                         
                        Button("Send Email",action:{
                            print("yo")
                 
                        }
                        
                        )
                         .foregroundColor(.white)
                         .frame(width: 300, height: 50)
                         .background(Color.green)
                         .cornerRadius(10)
                     }
                 
                 
                 
                 
                 

                     
                 }
            
             }
            
        }.navigationBarHidden(true)
    }
    
}
    


struct EmailView_Previews: PreviewProvider {
    static var previews: some View {
        EmailView()
    }
}
