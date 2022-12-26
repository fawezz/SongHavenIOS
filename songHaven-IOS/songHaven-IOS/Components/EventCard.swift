//
//  EventCard.swift
//  songHaven-IOS
//
//  Created by SongH on 20/12/2022.
//

import SwiftUI

struct EventCard: View {
    let event: Event
    var body: some View {
        HStack(spacing: 20){
            HStack(alignment: .center, spacing: 0){
              
                
                Text(event.title!)
                    .bold()
                    .foregroundColor(.purple)
                    .font(.subheadline)
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(width: 20, height: 20)
                    .padding(20)
                    .background(Color(.black))
                    .cornerRadius(20)
                    .shadow(color: .purple, radius: 5, x: 0, y: 0)

//                Text(event.!)
//                    .bold()
//                    .foregroundColor(.purple)
//                    .font(.subheadline)
//                    .fixedSize(horizontal: true, vertical: false)
//                    .frame(width: 20, height: 20)
//                    .padding(20)
//                    .background(Color(.black))
//                    .cornerRadius(20)
//                    .shadow(color: .purple, radius: 5, x: 0, y: 0)
            }
            
        
        }
        
    }
    }



