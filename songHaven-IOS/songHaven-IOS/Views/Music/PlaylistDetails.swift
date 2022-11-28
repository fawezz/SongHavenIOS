//
//  PlaylistDetails.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 28/11/2022.
//

import SwiftUI
import NavigationStack

struct PlaylistDetails: View {
    @StateObject var viewModel : PlaylistDetailsViewModel
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    var body: some View {
        NavigationStack{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    //search bar
                    
                    VStack(alignment: .leading){
//                        Text(viewModel.selectedPlaylist.title ?? "error getting title")
//                            .font(.title)
//                            .foregroundColor(.white)
                        ScrollView(.vertical){
                            LazyVStack{
                                ForEach($viewModel.songs, id: \._id) { song in
                                    PlayListDetailsRow(song: song.wrappedValue)
                                        .padding(.horizontal, 3)
                                        .onTapGesture {
                                            self.navigationStack.push(MusicPlayerView(viewModel: MusicPlayerViewModel(model: song.wrappedValue)))
                                        }
                                }
                            }
                        }
                    }
                }
                .padding(8)
                .navigationBarTitle(viewModel.selectedPlaylist.title!)
                .navigationBarItems(leading: BackButton(action: {navigationStack.pop()}))

            }
        }

    }
    
}

