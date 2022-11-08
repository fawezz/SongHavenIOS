//
//  Verification.swift
//  songHaven-IOS
//
//  Created by Cyrine-Faouze on 7/11/2022.
//

import SwiftUI

struct Verification: View {
    var body: some View {
        ZStack{
            LinearGradient(gradient: .init(colors: [.black, .pink]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack{
            Text("Confirmation code")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
         
                HStack{
                Circle().scale(0.9).foregroundColor(.white.opacity(0.15))
                    Circle().scale(0.9).foregroundColor(.white.opacity(0.15))
                    Circle().scale(0.9).foregroundColor(.white.opacity(0.15))
                    Circle().scale(0.9).foregroundColor(.white.opacity(0.15))
                }
                
            
            }
            
        }
}

struct Verification_Previews: PreviewProvider {
    static var previews: some View {
        Verification()
    }
}
}
