//
//  UserCard.swift
//  songHaven-IOS
//
//  Created by SongH on 6/12/2022.
//

import SwiftUI

struct  UserCard: View {
    let user: User
    @StateObject var viewModel = InvitationViewModel()
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 0){
            HStack(spacing : 90){
                HStack{
                    AsyncImage(url: URL(string: UserService.UserImageUrl + user.imageId!)){image in
                        image.image?
                        
                            .resizable()
                            .frame(width: 50, height: 50)
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
                    .fixedSize(horizontal: true, vertical: false)}
                    HStack{
                        Button (
                            action: {
                                
                                //viewModel. 
                                        },
                            label: {
                                Label("Add", systemImage: "person.crop.circle.badge.plus")
                            })
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

