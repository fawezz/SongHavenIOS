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
    @State var userSession = UserSession.shared
    
    init(){
        userSession.isAlreadySignedIn()
        let socketManager = SocketChatManager.init()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStackView{
                if(!userSession.isSignedIn){
                    LoginView().environment(\.managedObjectContext, persistenceController.container.viewContext)
                }else{
                    HomeView().environment(\.managedObjectContext, persistenceController.container.viewContext)
                }
                //CreateSongView(viewModel: CreateSongViewModel()).environment(\.managedObjectContext, persistenceController.container.viewContext)
            }.environmentObject(userSession)
            /*.onAppear(
              perform: {
              //                    PlaylistService.ModifyPlaylist(playlistId: "637d013fd35081e7c6c90d7a", title: "playlist7", completed:
              //                                            { (success, reponse) in print(success) })
              }
              )*/
        }
    }
}
