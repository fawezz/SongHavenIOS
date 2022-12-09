//
//  UserCard.swift
//  songHaven-IOS
//
//  Created by SongH on 6/12/2022.
//

import SwiftUI

struct  UserCard: View {
    let user: User
    var body: some View {
        VStack(alignment: .center, spacing: 0){
            AsyncImage(url: URL(string: UserService.UserImageUrl + user.imageId!)){image in
                image.image?
                
                    .resizable()
                    .frame(width: 100, height: 100)
            }
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.clear, lineWidth: 0))
            .shadow(radius: 10)
            .frame(width: 100,height: 120)
            .shadow(radius: 10)
            Text(user.firstname!)
                .bold()
                .foregroundColor(.purple)
                .font(.subheadline)
                .fixedSize(horizontal: true, vertical: false)
            
            Text(user.lastname!)
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

