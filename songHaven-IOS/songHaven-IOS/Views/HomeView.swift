//
//  HomeView.swift
//  songHaven-IOS
//
//  Created by zewaff on 24/11/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userSession: UserSession
    @State private var selectedTab : Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab){
            MusicHomeView(viewModel: MusicHomeViewModel())
                .tabItem( {
                    Label("Music", systemImage: "music.note.list")
                })
                .tag(0)
            Text("notifications")
            //CreateSongView()
                .tabItem({
                    Label("Notifications", systemImage: "bell")
                })
                .tag(1)
            UserBandsView()
                .tabItem({
                    Label("Band", systemImage: "person.3.fill")
                })
                .tag(2)
            ArtistEvents()
                  .tabItem( {
                      Label("Events", systemImage: "calendar")
                  })
                  .tag(3)
            ProfileView()
                .tabItem( {
                    Label("Profile", systemImage: "person")
                })
                .tag(4)
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
