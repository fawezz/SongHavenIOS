//
//  MusicSearchView.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 6/12/2022.
//

import SwiftUI
import NavigationStack

struct ArtistSuggestionView : View {
    @StateObject var viewModel : ArtistSuggetionViewModel
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 0){
                HStack{
                    BackButton(action: {navigationStack.pop()})
                    //SEARCH BAR
                    ZStack {
                        HStack {
                            Button(action: {
                                print("search pressed")
                                viewModel.searchUsers()
                            }) {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.purple)
                            }
                            .disabled(viewModel.searchText.isEmpty)
                            TextField($viewModel.searchText.wrappedValue == "title" ? "Search by Name.." : "Search by Name", text: $viewModel.searchText)

                                .foregroundColor(.main_color.opacity(0.8))
                            if(!viewModel.searchText.isEmpty){
                                Button(action: {
                                    print("clear pressed")
                                    viewModel.searchText = ""
                                }) {
                                    Text("Clear")
                                        .foregroundColor(.main_color.opacity(0.5))
                                }
                            }
                        }
                        .foregroundColor(.gray)
                        .padding(.all, 13)
                        .background(
                            .regularMaterial,
                            in: RoundedRectangle(cornerRadius: 8, style: .continuous)
                        )
                    }
                    .frame(height: 40)
                    .cornerRadius(13)
                    .padding()
                }
                .padding()
                if(!viewModel.searchedUsers.isEmpty){
                    VStack(alignment: .leading){
                        Text("Search Results")
                            .font(.title)
                            .foregroundColor(.white)
                        ScrollView(.vertical){
                            HStack{
                                
                                LazyVStack{
                                    ForEach($viewModel.searchedUsers, id: \._id) { user in
//                                        UserCard(user: user, actionInvite: {
//                                            viewModel.sendInitation(user: user)
//                                        }, viewModel: user)
                                       
                            }
                                }
                            }
                        }
                    }
                    .padding()
                }else{
                    Spacer()
                    Text("No matching user found")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding(.all, 20)
                    Spacer()
                }
                //LOADER
                if(viewModel.isLoading){
                    ZStack{
                        Color(.white)
                            .opacity(0.7)
                            .ignoresSafeArea()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                            .scaleEffect(3)
                    }
                }
            }
        }
    }
}
