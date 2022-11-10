//
//  NewPassword.swift
//  songHaven-IOS
//
//  Created by Cyrine-Faouze on 7/11/2022.
//

import SwiftUI

struct resetPasswordView: View {
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {     NavigationView{
         ZStack{  LinearGradient(gradient: .init(colors: [.purple , .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack {
               
                  
                
                Text("New Password")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white                                                )
                    .padding()
                TextField("Enter new password",text:$username)
                    .padding()
                    .frame(width: 300, height :50)
                    .foregroundColor(.white)
                    .background(Color.white.opacity(0.35))
                    .cornerRadius(10)
                TextField("Confirm Password",text:$username)
                    .padding()
                    .frame(width: 300, height :50)
                    .background(Color.white.opacity(0.35))
                    .cornerRadius(10)
                
       
               
                Button("Submit"){
                  
                    
                }
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.pink)
                .cornerRadius(10)
           
            }
            
        }
    }
        .navigationBarHidden(true)
}
    }


struct NewPassword_Previews: PreviewProvider {
    static var previews: some View {
        resetPasswordView()
    }
}
