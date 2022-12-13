//
//  BandCard.swift
//  songHaven-IOS
//
//  Created by SongH on 6/12/2022.
//

import SwiftUI

struct  BandCard: View {
    let band: Band
    
    var body: some View {
        VStack(alignment: .center, spacing: 0){
            AsyncImage(url: URL(string: BandService.BandImageUrl + band.image!)){image in
                image.image?
                    .resizable()
                    .frame(width: 100, height: 100)
            //   UITextPlaceholder()
            }
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.clear, lineWidth: 0))
            .shadow(radius: 10)
            .frame(width: 100,height: 120)
            .shadow(radius: 10)
                
            Text(band.name!)
                .bold()
                .foregroundColor(.purple)
                .font(.subheadline)
                .fixedSize(horizontal: true, vertical: false)
            
            Text((band.creator?.getFullName())!)
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
