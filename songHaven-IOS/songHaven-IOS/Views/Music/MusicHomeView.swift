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
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack{
                
                VStack(alignment: .leading){
                    Text("Most Popular")
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
                                //MusicPlayerViewModel.shared.config?(model: song.wrappedValue, currentPlaylist: nil)
                            }
                        }
                    }
                }
                VStack(alignment: .leading){
                    Text("Newest")
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
                    Text("Your Playlists")
                        .font(.title)
                        .foregroundColor(.white)
                    if(!$viewModel.userPlaylists.isEmpty){
                        ScrollView(.horizontal){
                            LazyHStack{
                                ForEach($viewModel.userPlaylists, id: \._id) { playlist in
                                    PlaylistCard(playlist: playlist.wrappedValue)
                                        .padding(.horizontal, 3)
                                        .onTapGesture {
                                            self.navigationStack.push(PlaylistDetails(viewModel: PlaylistDetailsViewModel(playlist: playlist.wrappedValue)))
                                        }
                                }
                            }
                        }
                    }else{
                        HStack{
                            Text("You don't have any playlists yet")
                                .foregroundColor(.main_color)
                                .padding(.all, 50)
                        }
                    }
                }
            }
            .padding(8)
        }
    }
}



/*
struct MusicHomeView: View {
    @StateObject var viewModel = MusicHomeViewModel()

    var body: some View {
        ZStack {
            Color.primary_color.edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    // Header
                    HomeHeaderView(headerStr: viewModel.headerStr)
                    // Playlists
                    HomeSongCard(playlists: viewModel.playlists, onSelect: viewModel.selectMusic(music:))
                    // Recently Played
                    RecentlyPlayedCard(recentlyPlayed: viewModel.recentlyPlayed, onSelect: viewModel.selectMusic(music:))
                    // Made for You
                    HomeMadeForView(onSelect: viewModel.selectMusic(music:))
                    
                    Spacer().frame(height: 150)
                    Spacer()
                }
                .fullScreenCover(isPresented: $viewModel.displayPlayer) {
                    if let model = viewModel.selectedMusic {
                        MusicPlayerView(viewModel: MusicPlayerViewModel(model: model))
                    }
                }
            }.animation(.spring()).edgesIgnoringSafeArea([.horizontal, .bottom])
        }
    }
}


fileprivate struct HomeHeaderView: View {
    let headerStr: String
    var body: some View {
        HStack(alignment: .center) {
            Text(headerStr).foregroundColor(.blue)
            Spacer()
            Button(action: {  }) {
//                Image.search.resizable().frame(width: 16, height: 16)
//                    .padding(12).background(Color.primary_color)
//                    .cornerRadius(20)
            }
        }.padding(.top, 12).padding(.horizontal, 10)
    }
}


fileprivate struct HomeSongCard: View {
    let playlists: [Song], onSelect: (Song) -> ()
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Your Playlist").foregroundColor(.blue)
               .padding(.leading, 10)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<playlists.count, id: \.self) { i in
                        Button(action: { onSelect(playlists[i]) }, label: {
                            SongCard(name: (playlists[i] as Song).title ?? "default title",
                                     artistName: (playlists[i].creator?.getFullName())!,
                                         coverImage: playlists[i].filename!)
                        }).padding(.top, 6).padding(.bottom, 40)
                    }
                }.padding(.horizontal, 10)
            }
        }.padding(.top, 36)
    }
}
struct SongCard: View {
    
    let name: String, artistName: String, coverImage: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
//            coverImage.resizable().scaledToFill()
//                .frame(width: 114, height: 88).cornerRadius(16)
            Text(name).foregroundColor(.red)
                .padding(.top, 12).padding(.bottom, 6)
            Text(artistName).foregroundColor(.red)
                .padding(.bottom, 8)
        }
        .padding(12).background(Color.primary_color)
        .cornerRadius(24)
    }
}

fileprivate struct RecentlyPlayedCard: View {
    let recentlyPlayed: [Song], onSelect: (Song) -> ()
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Recently Played").foregroundColor(.blue)
                .padding(.leading, 10)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<recentlyPlayed.count, id: \.self) { i in
                        Button(action: { onSelect(recentlyPlayed[i]) }, label: {
                            MusicDiscView(name: (recentlyPlayed[i] as Song).title!,
                                          artistName: (recentlyPlayed[i].creator?.getFullName())!,
                                          coverImage: recentlyPlayed[i].filename!)
                        }).padding(.top, 6).padding(.bottom, 40)
                    }
                }.padding(.horizontal, 10)
            }
        }
    }
}

struct MusicDiscView: View {
    
    let name: String, artistName: String, coverImage: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ZStack {
                Circle().foregroundColor(.primary_color)
                    .frame(width: 180, height: 180)
                ForEach(0..<10, id: \.self) { i in
                    RoundedRectangle(cornerRadius: (80 + CGFloat((6 * i))) / 2)
                        .stroke(lineWidth: 0.25)
                        .foregroundColor(.white)
                        .frame(width: 80 + CGFloat((6 * i)),
                               height: 80 + CGFloat((6 * i)))
                }
                coverImage.resizable().scaledToFill()
                    .frame(width: 70, height: 70).cornerRadius(35)
            }
            Text(name).foregroundColor(.blue)
                .padding(.top, 12).padding(.bottom, 6)
            Text(artistName).foregroundColor(.blue)
                .padding(.bottom, 8)
        }
    }
}



fileprivate struct HomeMadeForView: View {
    let onSelect: (Song) -> ()
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Made for You").foregroundColor(.green)
                .padding(.leading, 10)
            Button(action: { /*onSelect(Data.MADE_FOR_YOU) */}, label: {
                MadeForView()
            }).padding([.horizontal, .top], 10).padding(.bottom, 40)
        }
    }
}

struct MadeForView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
//            Image.profile_pic.resizable().scaledToFill()
//                .frame(width: 114, height: 140).cornerRadius(16)
            VStack(alignment: .leading, spacing: 8) {
                Text("Discover Weekly").foregroundColor(.gray)
                Text("Your weekly mixtape of fresh music. Enjoy new music and deep cuts picked for you.")
                    .foregroundColor(.yellow)
            }.padding(.leading, 12)
            Spacer()
        }
        .padding(12).background(Color.primary_color)
        .cornerRadius(24)
    }
}

struct MusicHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MusicHomeView()
    }
}
*/
