//
//  MusicSearchView.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 6/12/2022.
//

import SwiftUI
import NavigationStack

struct MusicSearchView: View {
    @StateObject var viewModel : MusicSearchViewModel
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
                                viewModel.searchSongs()
                            }) {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.purple)
                            }
                            .disabled(viewModel.searchText.isEmpty)
                            TextField("Search ..", text: $viewModel.searchText)
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
                if(!viewModel.searchedSongs.isEmpty){
                    VStack(alignment: .leading){
                        Text("Search Results")
                            .font(.title)
                            .foregroundColor(.white)
                        ScrollView(.vertical){
                            LazyVStack{
                                ForEach($viewModel.searchedSongs, id: \._id) { song in
                                    PlayListDetailsRow(song: song.wrappedValue)
                                        .padding(.horizontal, 3)
                                        .onTapGesture {
                                            MusicPlayerViewModel.setup(Configurations(model: song.wrappedValue, currentPlaylist: nil))
                                            self.navigationStack.push(MusicPlayerView(viewModel: MusicPlayerViewModel.shared ))
                                        }
                                }
                            }
                        }
                    }
                    .padding()
                }else{
                    Spacer()
                    Text("No matching songs found")
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
