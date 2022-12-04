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
    init(){

    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStackView{
                let token = UserDefaults.standard.string(forKey: "token")
                if(token == "" || token == nil){
                    LoginView().environment(\.managedObjectContext, persistenceController.container.viewContext)
                }else{
                    HomeView().environment(\.managedObjectContext, persistenceController.container.viewContext)
                }
                //CreateSongView(viewModel: CreateSongViewModel()).environment(\.managedObjectContext, persistenceController.container.viewContext)

            }/*.onAppear(
              perform: {
              //                    SongService.GetAllSongs(completed:
              //                                                { (success, reponse) in print(reponse!.count) })
              //                    SongService.GetByUser(creatorId: "", completed:
              //                                                { (success, reponse) in print("aaa") })
              //                    SongService.DeleteSong(songId: "", completed:
              //                                                { (success, reponse) in print("bbb") })
              //                    PlaylistService.GetByUser(ownerId: "", completed:
              //                                            { (success, reponse) in print("aaa") })
              //let arrayy = ["637d013fd35081e7c6c90d7a"]

              //                    PlaylistService.ModifyPlaylist(playlistId: "637d013fd35081e7c6c90d7a", title: "playlist7", completed:
              //                                            { (success, reponse) in print(success) })
              
              }
              )*/
        }
    }
}
