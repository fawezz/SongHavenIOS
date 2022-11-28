//
//  HomeView.swift
//  songHaven-IOS
//
//  Created by zewaff on 24/11/2022.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView{
           // MusicPlayerView(viewModel: MusicPlayerViewModel(model: , slider: 4))
            //MusicHomeView()
            Text("ho;e")
                .tabItem( {
                    Label("Music", systemImage: "music.note.list")
                })
            
            Text("notifications")
                .tabItem({
                    Label("Notifications", systemImage: "bell")
                })
            Text("Chat")
                .tabItem({
                    Label("Chat", systemImage: "message.fill")
                })
            ProfileView()
                .tabItem( {
                    Label("Profile", systemImage: "person")
                })
        }.onAppear(){
            UITabBar.appearance().backgroundColor = .black
        }
        .tint(.purple)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
