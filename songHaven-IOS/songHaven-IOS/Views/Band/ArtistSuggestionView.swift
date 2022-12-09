//
//  FriendsView.swift
//  songHaven-IOS
//
//  Created by cyrine on 18/11/2022.
//

import SwiftUI

struct ArtistSuggestionView: View {
    public var name = ""
    @StateObject var viewModel  = ArtistSuggetionViewModel()

    
    
    var body: some View {
        
        ZStack{
            LinearGradient(gradient: .init(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack{
                NavigationLink("", destination: ArtistSuggestionView())
            
                Text("SUGGESTION")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                VStack{
                    HStack{
                        Spacer() 
                        Text("Search...")
                            .padding(.top)
                            .frame(width: 300, height :50)
                            .background(Color.white.opacity(0.15))
                            .cornerRadius(50)
                            .foregroundColor(.white)
                        Button(
                            action:{},
                            label:{
                                Label("", systemImage: "magnifyingglass")
                                    .foregroundColor(.white)
                                    .padding(.leading, -50.0)
                            })
                    }
                    HStack{
                        Spacer()
                        if(!$viewModel.users.isEmpty){
                                ScrollView(.vertical){
                                    LazyVStack{
                                        ForEach($viewModel.users, id: \._id) { user in
                                            UserCard(user: user.wrappedValue)
                                                .padding(.horizontal, 3)
                                             
                                        }
                                    }
                                }
                            }

                        Button(
                            action:{},
                            label:{
                                Label("", systemImage: "person.badge.plus")
                                    .foregroundColor(.white)
                                    .padding(.leading, -50.0)
                            })
                    }
                        }
                        
                    }
                    .padding(.all)
                
            }
        }
    }

struct Register_Previews: PreviewProvider {
    static var previews: some View {
        ArtistSuggestionView()
    }
}


