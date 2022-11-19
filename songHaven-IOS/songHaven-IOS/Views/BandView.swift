//
//  BandView.swift
//  songHaven-IOS
//
//  Created by cyrine on 18/11/2022.
//

import SwiftUI

struct BandView: View {
    @State private var name = ""
    private var data : [Int] = Array(1...20)
    private let colors : [Color] = [.purple]
    private let adaptiveColumns = [
        
        GridItem (.adaptive(minimum: 170))
        
        
    ]
    
    var body: some View {
        NavigationView{
            
            ZStack{
                LinearGradient(gradient: .init(colors: [.black, .purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
                
                
                VStack{
                    
                    Text("Friends & Groups")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                    
                    TextField("Search...",text:$name)
                        .padding()
                        .frame(width: 300, height :50)
                        .background(Color.white.opacity(0.15))
                        .cornerRadius(50)
                        .foregroundColor(.white)
                    
                    
                   
                    VStack{
                        
                        HStack{
                            
                            NavigationLink( destination: FriendsView()
                            
                                .navigationBarBackButtonHidden(true)){
                               
                                
                                Text("FRIEND")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 130, height: 50)
                                    .background(Color.clear)
                                    .cornerRadius(15.0)
                            }
            
                                Text("BANDS")
                                    .bold()
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 130, height: 50)
                                    .background(Color.clear)
                                    .cornerRadius(15.0)
                            
                            
                            NavigationLink( destination: RequestView()
                                .navigationBarBackButtonHidden(true)){
                                
                                Text("REQUESTS")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 130, height: 50)
                                    .background(Color.clear)
                                    .cornerRadius(15.0)
                                
                                
                            }
                        }

                    }
                    
                    ScrollView{
                        LazyVGrid(columns:adaptiveColumns, spacing: 20){
                            
                            
                            ForEach(data, id: \.self ){ number in
                                ZStack{
                                    
                                    Rectangle()
                                        .frame(width: 130, height: 130)
                                        .opacity(0.20)
                                        .cornerRadius(30)
                                    VStack{
                                        Image("User")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 50)
                                        
                                        Text("cyrine")
                                            .foregroundColor(.white)
                                            .font(.system(size: 20, weight: .medium, design: .rounded))
                                    }
                                    
                                    
                                }
                                
                                
                            }
                        }
                        
                    }
                }.padding(.all)
            }
            
        }
    }
        struct BandView_Previews: PreviewProvider {
            static var previews: some View {
                BandView()
            }
        }
    }

