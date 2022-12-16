//
//  SplashScreen.swift
//  songHaven-IOS
//
//  Created by Cyrine-Faouze on 7/11/2022.
//
import SwiftUI
import NavigationStack
import LocalAuthentication

struct SplashScreen: View {
    @State var isActive: Bool = false
    @State var userSession = UserSession.shared

    var body: some View {
        if(self.isActive){
            NavigationStackView{
                if(!userSession.isSignedIn){
                    LoginView()
                }else{
                    HomeView()
                }
            }.environmentObject(userSession)
        }else{
            ZStack{
                LinearGradient(gradient: .init(colors: [.black, .purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 400)
                
            }.onAppear{
                if(userSession.isSignedIn){
                    let socketManager = SocketChatManager.shared
                    socketManager.setupSocketEvents()
                    //authenticateWithId()
                }
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

func authenticateWithId(){
    let context = LAContext()
    var error : NSError?
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
        let reason = "Authenticate with FACE ID"
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason:reason) { success, authenticateError in
            DispatchQueue.main.async {
                if success {
                    
                }else{
                    
                }
            }
        }
    }else{
        //face if not available
    }
}
