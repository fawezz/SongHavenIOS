//
//  RequestView.swift
//  songHaven-IOS
//
//  Created by cyrine on 18/11/2022.
//

import SwiftUI

struct BandRequestView: View {
    @State private var name = ""
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: .init(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                
                VStack{
                    
                    Text("Artists & Bands")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                    
           
                    VStack{
                        HStack{
                            
                            TextField("Search...",text:$name)
                                .padding()
                                .frame(width: 300, height :50)
                                .background(Color.white.opacity(0.15))
                                .cornerRadius(50)
                                .foregroundColor(.white)
                            
                            Button(
                                
                                action:{
                                
                                    
                                }, label:{
                                    Label("", systemImage: "magnifyingglass")
                                        .foregroundColor(.white)
                                        .padding(.leading, -50.0)
                                })
                            
                        }
                        .padding()
                        
                        HStack{
                            
                            NavigationLink( destination: ArtistSuggestionView()
                                .navigationBarBackButtonHidden(true)){
                                Text("SUGGESTION")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .fixedSize()
                                    .frame(width: 130, height: 50)
                                    .background(Color.clear)
                                    .cornerRadius(15.0)
                            }
                            NavigationLink( destination: BandsView()
                                .navigationBarBackButtonHidden(true)){
                                Text("BANDS")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 130, height: 50)
                                    .background(Color.clear)
                                    .cornerRadius(15.0)
                            }
                           
                                
                                Text("REQUESTS")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 130, height: 50)
                                    .background(Color.clear)
                                    .cornerRadius(15.0)
                            
                        }
                        
                       
                        
                    }
                    
                    ScrollView{
                        RequestRowItem()
                        RequestRowItem()
                        RequestRowItem()
                        RequestRowItem()
                        RequestRowItem()
                    }
                }
                .padding(.top)
                
                
                
           
                
            }
            
            
        }
    }
    
    struct RequestView_Previews: PreviewProvider {
        static var previews: some View {
            BandRequestView()
        }
    }
    struct RequestRowItem: View {
        var body: some View {
            HStack{
                
                Image("User")
                    .resizable()
                    .clipShape(Circle())
                    .scaledToFit()
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .frame(width: 50,height: 50)
                
                Text("Jean Paul")
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                HStack{
                    Button ("Accept",action:{
                        
                    }
                        )
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .buttonStyle(.bordered)
         
                   
                    .cornerRadius(15.0)
                    
                    Button("Reject", role:.destructive ,action: {
                        
                    })
                    
                  
                    
                    
                    
                }
                
                Spacer()
                
            } .padding(.all)
            
        }
        
    }
    
}
