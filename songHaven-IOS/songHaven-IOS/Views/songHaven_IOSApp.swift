//
//  songHaven_IOSApp.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 7/11/2022.
//

import SwiftUI
import NavigationStack
import AVFAudio

@main
struct songHaven_IOSApp: App {
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(MyAppDelegate.self) private var appDelegate
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    @State var userSession = UserSession.shared
    
    init(){
        userSession.isAlreadySignedIn()
        UserDefaults.standard.set(0, forKey: "currentTabIndex")
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStackView{
                SplashScreen().environment(\.managedObjectContext, persistenceController.container.viewContext)
//                if(!userSession.isSignedIn){
//                    LoginView().environment(\.managedObjectContext, persistenceController.container.viewContext)
//                }else{
//                    HomeView().environment(\.managedObjectContext, persistenceController.container.viewContext)
//                }
            }.environmentObject(userSession)
            //CreateSongView(viewModel: CreateSongViewModel()).environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        
    }
}
