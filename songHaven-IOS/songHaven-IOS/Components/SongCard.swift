//
//  SongCard.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 28/11/2022.
//

import SwiftUI

struct SongCard: View {
    let song : Song
    var body: some View {
        VStack(alignment: .center){
            Image("logo")
                .resizable()
                .scaledToFit()
                .shadow(radius: 10)
                .frame(width: 80,height: 80)
            Text(song.title!)
                .bold()
                .foregroundColor(.purple)
                .font(.subheadline)
                .fixedSize(horizontal: true, vertical: false)
            Text((song.creator?.getFullName())!)
                .foregroundColor(.white)
                .font(.caption)
        }
        .frame(width: 100, height: 100)
        .padding(20)
        .background(Color(.black))
        .cornerRadius(20)
        .shadow(color: .purple, radius: 5, x: 0, y: 0)
    }
}

//struct SongCard_Previews: PreviewProvider {
//    static var previews: some View {
//        SongCard()
//    }
//}

