//
//  PlaylistCard.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 28/11/2022.
//

import SwiftUI

struct PlaylistCard: View {
    let playlist : Playlist
    var body: some View {
        VStack(alignment: .center){
            Text(playlist.title!)
                .bold()
                .foregroundColor(.purple)
            Text((playlist.songs?.count.description)! + " Songs")
                .foregroundColor(.white)
        }
        .frame(width: 120, height: 60)
        .padding(20)
        .background(Color(.black))
        .cornerRadius(20)
        .shadow(color: .purple, radius: 5, x: 0, y: 0)
    }
    
}

