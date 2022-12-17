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
    @State var faceIdSuccess: Bool = false
    @State var faceIdAvailable: Bool = false
    @State var showNextScreen: Bool = false
    @State var userSession = UserSession.shared
    
    var body: some View {
        if(self.isActive && self.showNextScreen){
            if(!userSession.isSignedIn){
                NavigationStackView{
                    LoginView()
                }.environmentObject(userSession)
            }else{
                NavigationStack{
                    HomeView()
                }.environmentObject(userSession)
            }
        }else{
            ZStack{
                LinearGradient(gradient: .init(colors: [.black, .purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 400)
            }.onAppear{
                if(userSession.isSignedIn){
                    authenticateWithId()
                    let socketManager = SocketChatManager.shared
                    socketManager.setupSocketEvents()
                }else{
                    self.showNextScreen = true  //allows showing login page if user not logged in
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                    withAnimation{self.isActive = true}
                }
            }
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
                        print("success")
                        self.faceIdSuccess = true
                        self.faceIdAvailable = true
                        self.showNextScreen = true
                    }else{
                        print("fail")
                        self.faceIdSuccess =  false
                        self.faceIdAvailable = true
                        exit(0)
                    }
                }
            }
        }else{
            //face if not available
            self.faceIdAvailable = false
            self.showNextScreen = true
            
            print("not available")
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}


