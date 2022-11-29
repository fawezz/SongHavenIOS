//
//  BandDetailView.swift
//  songHaven-IOS
//
//  Created by SongH on 21/11/2022.
//

import SwiftUI

struct BandDetailView: View {
    @State private var bandName = ""
    @State private var description = ""

    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: .init(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                
                VStack{
                    Spacer()
                    
                    Button(
                        action:{
                            
                            
                            
                        
                            
                        }, label:{
                            Label("Back", systemImage: "arrowshape.left.fill")
                                .foregroundColor(.white)
                                .padding(.leading, -150.0)
                        }
                    
                    )
                    
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
                    
                    Text("Metallica")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                        .padding(.all)
                    
                    Text("       Metallica is an American heavy metal band. The band was formed in 1981 in Los Angeles by vocalist/guitarist James Hetfield and drummer Lars Ulrich and has been based in San Francisco for most of its career.")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .padding(.all)
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
