//
//  InvitationCard.swift
//  songHaven-IOS
//
//  Created by SongH on 14/12/2022.
//

import SwiftUI


struct InvitationCard: View {
    
    @StateObject var viewModel : InvitationViewModel
    let band: Band
    var body: some View {
        HStack(spacing: 20){
            HStack(alignment: .center, spacing: 0){
                AsyncImage(url: URL(string: BandService.BandImageUrl + band.image!)){image in
                    image.image?
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 0))
                .shadow(radius: 10)
                .frame(width: 20,height: 20)
                .shadow(radius: 10)
                
                Text(band.name!)
                    .bold()
                    .foregroundColor(.purple)
                    .font(.subheadline)
                    .fixedSize(horizontal: true, vertical: false)
                
                    .frame(width: 20, height: 20)
                    .padding(20)
                    .background(Color(.black))
                    .cornerRadius(20)
                    .shadow(color: .purple, radius: 5, x: 0, y: 0)
            }
            
            HStack{
                
                Button(action:{
                   // viewModel.a
                    
                })
                {
                    Text("Accept")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 100, height: 50)
                        .cornerRadius(15.0)
                        .background(.green)
                    
                    
                    Button(action:{
                        
                    })
                    {
                        Text("Reject")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 100, height: 50)
                            .cornerRadius(15.0)
                            .background(.red)
                    }
                    
                }
                
            }
        }
        
    }
}
