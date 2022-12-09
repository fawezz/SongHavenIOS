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
            MusicHomeView(viewModel: MusicHomeViewModel())
                .tabItem( {
                    Label("Music", systemImage: "music.note.list")
                })
            Text("notifications")
                .tabItem({
                    Label("Notifications", systemImage: "bell")
                })
            UserBandsView()
                .tabItem({
                    Label("Band", systemImage: "person.3.fill")
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
