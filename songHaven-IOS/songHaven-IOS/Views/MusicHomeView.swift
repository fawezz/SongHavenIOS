//
//  MusicHomeView.swift
//  songHaven-IOS
//
//  Created by zewaff on 26/11/2022.
//

import SwiftUI
/*
struct MusicHomeView: View {
    @StateObject var viewModel = ProfileViewModel()

    var body: some View {
        ZStack {
            Color.primary_color.edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    // Header
                    HomeHeaderView(headerStr: viewModel.headerStr)
                    // Playlists
                    HomePlaylistView(playlists: viewModel.playlists, onSelect: viewModel.selectMusic(music:))
                    // Recently Played
                    HomeRecentlyPlayedView(recentlyPlayed: viewModel.recentlyPlayed, onSelect: viewModel.selectMusic(music:))
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
                Image.search.resizable().frame(width: 16, height: 16)
                    .padding(12).background(Color.primary_color)
                    .cornerRadius(20)
            }
        }.padding(.top, 12).padding(.horizontal, 10)
    }
}


fileprivate struct HomePlaylistView: View {
    let playlists: [Song], onSelect: (Song) -> ()
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Your Playlist").foregroundColor(.blue)
               .padding(.leading, 10)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<playlists.count, id: \.self) { i in
                        Button(action: { onSelect(playlists[i]) }, label: {
                            PlaylistView(name: (playlists[i] as Song).title,
                                         artistName: playlists[i].creator?.firstname + " " playlists[i].creator?.lastname,
                                         coverImage: playlists[i].filename)
                        }).padding(.top, 6).padding(.bottom, 40)
                    }
                }.padding(.horizontal, 10)
            }
        }.padding(.top, 36)
    }
}
struct PlaylistView: View {
    
    let name: String, artistName: String, coverImage: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            coverImage.resizable().scaledToFill()
                .frame(width: 114, height: 88).cornerRadius(16)
            Text(name).foregroundColor(.red)
                .padding(.top, 12).padding(.bottom, 6)
            Text(artistName).foregroundColor(.red)
                .padding(.bottom, 8)
        }
        .padding(12).background(Color.primary_color)
        .cornerRadius(24)
    }
}

fileprivate struct HomeRecentlyPlayedView: View {
    let recentlyPlayed: [Song], onSelect: (Song) -> ()
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Recently Played").foregroundColor(.text_header)
                .padding(.leading, 10)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<recentlyPlayed.count, id: \.self) { i in
                        Button(action: { onSelect(recentlyPlayed[i]) }, label: {
                            MusicDiscView(name: (recentlyPlayed[i] as Song).title,
                                          artistName: recentlyPlayed[i].creator,
                                          coverImage: recentlyPlayed[i].coverImage)
                        }).padding(.top, 6).padding(.bottom, 40)
                    }
                }.padding(.horizontal, 10)
            }
        }
    }
}

struct MusicDiscView: View {
    
    let name: String, artistName: String, coverImage: Image
    
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
            Button(action: { onSelect(Data.MADE_FOR_YOU) }, label: {
                MadeForView()
            }).padding([.horizontal, .top], 10).padding(.bottom, 40)
        }
    }
}

struct MadeForView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Image.profile_pic.resizable().scaledToFill()
                .frame(width: 114, height: 140).cornerRadius(16)
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
