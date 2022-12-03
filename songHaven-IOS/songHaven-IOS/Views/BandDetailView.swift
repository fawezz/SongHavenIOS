//
//  BandDetailView.swift
//  songHaven-IOS
//
//  Created by SongH on 21/11/2022.
//

import SwiftUI

struct BandDetailView: View {
    @State private var bandName = ""
    @State private var discription = ""
    @ObservedObject var viewModel = BandDetailViewModel()


    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: .init(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                
                VStack{
                    
                    
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
             
       
                    
                  
                    
                }
                .padding(.all)
                
                VStack{
                 
               
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
                    
                    
                    
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.all)
                        .frame(width: 200, height: 200)
                    
                    VStack(spacing: 5) {
                        Text(viewModel.name + " " + viewModel.discription)
                            .bold()
                            .font(.title)
                            .foregroundColor(.white)
                    }.padding()
                }
                .padding(.all)
            }
            
        }
    }
    
    struct BandDetailView_Previews: PreviewProvider {
        static var previews: some View {
            BandDetailView()
        }
    }
}
