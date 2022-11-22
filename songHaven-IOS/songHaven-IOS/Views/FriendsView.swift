//
//  FriendsView.swift
//  songHaven-IOS
//
//  Created by cyrine on 18/11/2022.
//

import SwiftUI

struct FriendsView: View {
    @State private var nbrF = ""
    @State private var name = ""
    
    var body: some View {
        
        ZStack{
            LinearGradient(gradient: .init(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack{
        
                NavigationLink("", destination: FriendsView())
                Spacer()
                    Text("Artists & Bands")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                        .padding()

                VStack{
                    Spacer()
                    HStack{
                    
                    TextField("Search...",text:$name)
                            .padding(.top)
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
                    Spacer()
                    HStack{
                        
                        
                            Text("SUGGESTION")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .fixedSize()
                                .frame(width: 130, height: 50)
                                .background(Color.clear)
                                .cornerRadius(15.0)
                                .bold()
                        
                        
                        NavigationLink( destination: BandView()
                            .navigationBarBackButtonHidden(true)){
                            Text("BANDS")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 130, height: 50)
                                .background(Color.clear)
                            .cornerRadius(15.0)
                            
                        }
                        
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
                    .padding(.top)
                        
                    
                }
                
                FriendRowItem()
                FriendRowItem()
                FriendRowItem()
                FriendRowItem()
            
                
                }
                
                
                
                
            }
        
            
        }
    }
    struct Register_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                FriendsView()
            }
            
            
        }
        
        
        
    }

struct FriendRowItem: View {
var body: some View {
    Spacer()
    HStack{
    
        Image("User")
            .resizable()
            .clipShape(Circle())
            .scaledToFit()
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
            .frame(width: 50,height: 50)
        VStack{
            Text("Jean Paul")
                .bold()
                .foregroundColor(.white)
                .padding()
        
        }
        Spacer()
        Button ("Invite",action:{
            
        }
            )
        .font(.headline)
        .foregroundColor(.white)
        .padding()
        .buttonStyle(.bordered)


        
    }.padding(.all)
    

}
}


