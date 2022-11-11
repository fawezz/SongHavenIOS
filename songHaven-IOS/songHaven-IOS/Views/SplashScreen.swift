//
//  SplashScreen.swift
//  songHaven-IOS
//
//  Created by Cyrine-Faouze on 7/11/2022.
//

import SwiftUI

struct SplashScreen: View {
    @State var isActive: Bool = false
    var body: some View {
        if(self.isActive){
            VerificationCodeView()
        }else{
            ZStack{
                LinearGradient(gradient: .init(colors: [.black, .purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 400)
                
            }.onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                    withAnimation{self.isActive = true}
                }
            }
        }
        
    
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}

