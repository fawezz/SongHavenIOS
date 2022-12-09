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
           
            HStack{
                AsyncImage(url: URL(string: UserService.UserImageUrl + user.imageId!)){image in
                    image.image?
                    
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 10)
                .frame(width: 20,height: 30)
                .shadow(radius: 10)
                Text(user.firstname!)
                    .bold()
                    .foregroundColor(.purple)
                    .font(.subheadline)
                    .fixedSize(horizontal: true, vertical: false)
                
                Text(user.lastname!)
                    .bold()
                    .foregroundColor(.purple)
                    .font(.subheadline)
                    .fixedSize(horizontal: true, vertical: false)
                
                
                Button(action: {
                   // viewModel.addBand()
                    
                }) {
                    Label("Add", systemImage: "person.fill.badge.plus")
                        .frame(width: 20, height: 20)
                        .padding(20).background(Color.clear.opacity(0.7))
                        .cornerRadius(20)
                        .shadow(color: Color.black,radius: 8, x: 0, y: 5)
                }
                
            }
           
        }
        .frame(width: 300, height: 20)
        .padding(20)
        .background(Color(.black))
        .cornerRadius(20)
        .shadow(color: .purple, radius: 5, x: 0, y: 0)
    }
}

