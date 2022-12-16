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
            /*.onAppear(
              perform: {
              //                    PlaylistService.ModifyPlaylist(playlistId: "637d013fd35081e7c6c90d7a", title: "playlist7", completed:
              //                                            { (success, reponse) in print(success) })
              }
              )*/
        }
    }
}
