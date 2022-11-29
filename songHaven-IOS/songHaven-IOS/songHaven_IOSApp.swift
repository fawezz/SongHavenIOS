//
//  songHaven_IOSApp.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 7/11/2022.
//

import SwiftUI
import NavigationStack

@main
struct songHaven_IOSApp: App {
    let persistenceController = PersistenceController.shared
    
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
              //                    PlaylistService.AddSong(playlistId: "637d013fd35081e7c6c90d7a", songId: "637d785689c0e4e674a0c614", completed:
              //                                            { (success, reponse) in print(success) })
              //                    PlaylistService.RemoveSong(playlistId: "637d013fd35081e7c6c90d7a", songId: "637d785689c0e4e674a0c614", completed:
              //                                            { (success, reponse) in print(success) })
              //let arrayy = ["637d013fd35081e7c6c90d7a"]
              //                    PlaylistService.CreatePlaylist(title: "test playlist", ownerId: "636459ab1ba58bdd172e92bd", songs: [], completed:
              //                                            { (success, reponse) in print(success) })
              //                    PlaylistService.ModifyPlaylist(playlistId: "637d013fd35081e7c6c90d7a", title: "playlist7", completed:
              //                                            { (success, reponse) in print(success) })
              
              }
              )*/
        }
    }
}
