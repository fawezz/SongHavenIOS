//
//  MusicHomeView.swift
//  songHaven-IOS
//
//  Created by zewaff on 26/11/2022.
//

import SwiftUI
import NavigationStack
struct MusicHomeView: View {
    @StateObject var viewModel : MusicHomeViewModel
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    @StateObject private var languageService = LocalizationService.shared

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack{
                //SEARCH BAR
                ZStack {
                    HStack{
                        HStack {
                            Button(action: {
                                self.navigationStack.push(MusicSearchView(viewModel: MusicSearchViewModel(criteria: viewModel.criteria, searchText: viewModel.searchText)))
                                
                            }) {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.purple)
                            }
                            .disabled(viewModel.searchText.isEmpty)
                            TextField($viewModel.criteria.wrappedValue == "title" ? "homeViewTxt1.1".localized(languageService.language)
                                      : "homeViewTxt1.2".localized(languageService.language), text: $viewModel.searchText)
                                .foregroundColor(.main_color.opacity(0.8))
                            if(!viewModel.searchText.isEmpty){
                                Button(action: {
                                    viewModel.searchText = ""
                                }) {
                                    Text("Clear")
                                        .foregroundColor(.main_color.opacity(0.5))
                                }
                            }
                        }
                        .foregroundColor(.gray)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 8))
                        .background(
                            .regularMaterial,
                            in: RoundedRectangle(cornerRadius: 10, style: .continuous)
                        )
                        Menu {
                            Button(action: {
                                viewModel.criteria = "title"
                            }) {
                                Label("homeViewTxt1.1".localized(languageService.language), systemImage: "music.note")
                            }
                            Button(action: {
                                viewModel.criteria = "genre"
                            }) {
                                Label("homeViewTxt1.2".localized(languageService.language), systemImage: "music.note.list")
                            }
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.regularMaterial)
                                    .frame(width: 40, height: 40)
                                Image(systemName: "slider.horizontal.3")
                                    .foregroundColor(.main_color)
                                    .frame(height: 35)
                            }
                        }
                    }
                
            }
            .frame(height: 40)
            .cornerRadius(13)
            .padding()
            
            VStack(alignment: .leading){
                Text("homeViewTxt2".localized(languageService.language))
                    .font(.title)
                    .foregroundColor(.white)
                ScrollView(.horizontal){
                    LazyHStack{
                        ForEach($viewModel.pupularSongs, id: \._id) { song in
                            SongCard(song: song.wrappedValue)
                                .padding(.horizontal, 3)
                                .onTapGesture {
                                    MusicPlayerViewModel.setup(Configurations(model: song.wrappedValue, currentPlaylist: nil))
                                    self.navigationStack.push(MusicPlayerView(viewModel: MusicPlayerViewModel.shared ))
                                }
                        }
                    }
                }
            }
            VStack(alignment: .leading){
                Text("homeViewTxt3".localized(languageService.language))
                    .font(.title)
                    .foregroundColor(.white)
                ScrollView(.horizontal){
                    LazyHStack{
                        ForEach($viewModel.newestSongs, id: \._id) { song in
                            SongCard(song: song.wrappedValue)
                                .padding(.horizontal, 3)
                                .onTapGesture {
                                    MusicPlayerViewModel.setup(Configurations(model: song.wrappedValue, currentPlaylist: nil))
                                    self.navigationStack.push(MusicPlayerView(viewModel: MusicPlayerViewModel.shared ))
                                }
                        }
                    }
                }
            }
            VStack(alignment: .leading){
                Text("homeViewTxt4".localized(languageService.language))
                    .font(.title)
                    .foregroundColor(.white)
                if(!$viewModel.userPlaylists.isEmpty){
                    ScrollView(.horizontal){
                        LazyHStack{
                            ForEach($viewModel.userPlaylists, id: \._id) { playlist in
                                PlaylistCard(playlist: playlist.wrappedValue)
                                    .padding(.horizontal, 3)
                                    .onTapGesture {
                                        self.navigationStack.push(PlaylistDetailsView(viewModel: PlaylistDetailsViewModel(playlist: playlist.wrappedValue)))
                                    }
                            }
                        }
                    }
                }else{
                    HStack{
                        Text("homeViewTxt5".localized(languageService.language))
                            .foregroundColor(.main_color)
                            .padding(.all, 50)
                    }
                }
            }
        }
        .padding(8)
        
        //LOADER
        if(!viewModel.isDataReceived()){
            ZStack{
                Color(.white)
                    .opacity(0.7)
                    .ignoresSafeArea()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                    .scaleEffect(3)
            }
        }
        }.onAppear(perform: {
            viewModel.fetchUserPlaylists()
            viewModel.fetchNewestSongs()
        })
}
}
