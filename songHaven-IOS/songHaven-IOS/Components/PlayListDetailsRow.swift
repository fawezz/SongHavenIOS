//
//  PlayListDetailsRow.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 28/11/2022.
//

import SwiftUI

struct PlayListDetailsRow: View {
    var song : Song
    var body: some View {
        HStack(alignment: .center){
            Image("logo")
                .resizable()
                .scaledToFit()
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .frame(width: 50,height: 50)
            Spacer()
            VStack(){
                Text(song.title ?? "default title")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.black)
                Text(song.creator?.getFullName() ?? "artist name")
                    .font(.caption)
                    .foregroundColor(.black)
            }.padding(.vertical, 50)
            Spacer()
        }
        .frame(width: .infinity, height: 40)
        .padding(.all, 20)
        .background(.thinMaterial)
        .cornerRadius(20)
    }
}

//struct PlayListDetailsRow_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayListDetailsRow()
//    }
//}
