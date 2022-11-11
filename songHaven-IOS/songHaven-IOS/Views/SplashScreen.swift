//
//  SplashScreen.swift
//  songHaven-IOS
//
//  Created by Cyrine-Faouze on 7/11/2022.
//

import SwiftUI

struct SplashScreen: View {
    /*
    let date = Date.now.addingTimeInterval(5)
    let timer = Timer (fireAt: date, interval: 0, target:Self, selector: NavigationLink( destination: LoginView()), userInfo: nil, repeats: false)
    RunLoop.main.add(timer, forMode: .common)*/

    var body: some View {
        ZStack{
            LinearGradient(gradient: .init(colors: [.black, .purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400, height: 400)
            
            
            
        }
    
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}

}
