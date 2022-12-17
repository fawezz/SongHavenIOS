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
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: .init(colors: [.black, .purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400, height: 400)
        }.onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                withAnimation{self.isActive = true}
                if(userSession.isSignedIn){
                    userSession.isAlreadySignedIn()
                    //authenticateWithFaceId()
                    //let socketManager = SocketChatManager.shared
                    //socketManager.setupSocketEvents()
                    navigationStack.push(HomeView()) //// remove this line if faceId is active
                }else{
                    navigationStack.push(LoginView())
                }
            }
        }
    }
    func authenticateWithFaceId(){
        let context = LAContext()
        var error : NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "Authenticate with FACE ID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason:reason) { success, authenticateError in
                DispatchQueue.main.async {
                    if success {
                        print("success")
                        navigationStack.pop()
                        navigationStack.push(HomeView())
                    }else{
                        print("fail")
                        exit(0)
                    }
                }
            }
        }else{
            //face if not available
            print("not available")
            navigationStack.push(HomeView())
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}

//
//if(self.isActive && self.showNextScreen){
//    if(!userSession.isSignedIn){
//        navigationStack.push(LoginView())
////                NavigationStackView{
////                    LoginView()
////                }.environmentObject(userSession)
//    }else{
//        NavigationStack{
//            HomeView()
//        }.environmentObject(userSession)
//    }
//}
