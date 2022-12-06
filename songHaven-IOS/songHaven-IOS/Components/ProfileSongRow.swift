//
//  ProfileSongRow.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 6/12/2022.
//

import SwiftUI

struct ProfileSongRow: View {
    var song: Song
    var body: some View {
        HStack{
            Image("logo")
                .resizable()
                .clipShape(Circle())
                .scaledToFit()
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .frame(width: 50,height: 50)
            Spacer()
            Text(song.title!)
                .bold()
                .foregroundColor(.white)
                .padding()
        }
        .frame(width: .infinity, height: 25)
        .padding(.all, 20)
        .background(.thinMaterial)
        .cornerRadius(20)
    }
}


