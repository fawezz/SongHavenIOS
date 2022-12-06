//
//  BandDetailView.swift
//  songHaven-IOS
//
//  Created by SongH on 21/11/2022.
//

import SwiftUI
import Foundation
struct BandDetailView: View {
    
    @StateObject var viewModel : BandDetailViewModel
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: .init(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                VStack{
                    VStack(spacing: 30){
                        HStack(spacing:210){
                            Button(
                                action: {
                                    
                                }, label:{
                                    Label("Remove Band", systemImage: "trash")
                                })
                            .padding([.top, .leading, .trailing], -90.0)
                            
                            .foregroundColor(.white)
                            Button(
                                action: {
                                    
                                }, label:{
                                    Label("Edit Band", systemImage: "square.and.pencil")
                                })
                            .padding([.top, .leading, .trailing], -90.0)
                            
                            .foregroundColor(.white)

                        }
                        .padding(.leading, 67.0)
                        HStack(spacing:210){
                            Button(
                                action: {
                                    
                                }, label:{
                                    Label("Members", systemImage: "person.2.fill")
                                })
                            .padding([.top, .leading, .trailing], -90.0)
                            
                            .foregroundColor(.white)
                            
                            
                            Button(
                                action: {
                                    
                                }, label:{
                                    Label("Add Artist", systemImage: "person.fill.badge.plus")
                                })
                            .padding([.top, .leading, .trailing], -90.0)
                            
                            .foregroundColor(.white)
                            
                        }
                        .padding(.leading, 67.0)
                    }
                    
                    AsyncImage(url: URL(string: BandService.BandImageUrl + viewModel.selectedBand.image!))
                    {image in image.image?
                            .resizable()
                            .frame(width: 300, height: 300)
                    }
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 0))
                    .shadow(radius: 10)
                    .frame(width: 300,height: 300)
                    .shadow(radius: 10)
                        
                    VStack(spacing: 5) {
                        Text(viewModel.selectedBand.name! )
                            .font(.largeTitle)
                            .foregroundColor(.white)
                        
                        Text( viewModel.selectedBand.discription!)
                            .bold()
                            .foregroundColor(.white)
                    }.padding()
                }
            }
            
        }
    }
    
    
    
}
