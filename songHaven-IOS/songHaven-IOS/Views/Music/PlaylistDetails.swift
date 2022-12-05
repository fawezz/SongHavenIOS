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
                VStack(alignment: .center){
                    //search bar
                    if(viewModel.songs.isEmpty){
                        Text("No songs added to playlist yet")
                            .padding(.top, 20)
                            .font(.title3)
                            .foregroundColor(.gray.opacity(0.8))
                    }else{
                        List{
                            ForEach($viewModel.songs, id: \._id) { song in
                                PlayListDetailsRow(song: song.wrappedValue)
                                    .padding(.horizontal, 3)
                                    .onTapGesture {
                                        //self.navigationStack.push(MusicPlayerView(viewModel: MusicPlayerViewModel(model: song.wrappedValue, currentPlaylist: viewModel.selectedPlaylist)))
                                        MusicPlayerViewModel.setup(Configurations(model: song.wrappedValue, currentPlaylist: viewModel.selectedPlaylist))
                                        self.navigationStack.push(MusicPlayerView(viewModel: MusicPlayerViewModel.shared ))
                                    }
                                    .swipeActions(allowsFullSwipe: false) {
                                        Button {
                                            viewModel.removeSongFromPlaylist(swipedSong: song.wrappedValue)
                                            print("remove song")
                                        } label: {
                                            Label("remove", systemImage: "trash.fill")
                                        }
                                        .tint(.red.opacity(0.8))
                                    }
                                    .listRowSeparator(.hidden)
                                    .listRowBackground(
                                        Color.purple
                                            .clipped()
                                            .cornerRadius(20)
                                            .padding(EdgeInsets(top: 15, leading: 25, bottom: 10, trailing: 25))
                                    )
                            }
                        }
                        .scrollContentBackground(.hidden)
                    }
                }
                .padding(8)
                .navigationBarTitle(viewModel.selectedPlaylist.title!)
                .navigationBarItems(
                    leading: BackButton(action: {navigationStack.pop()}),
                    trailing: Button(
                        action: {
                            print("delete playlist")
                            viewModel.showAlert = true
                        } ) {
                            Image(systemName: "trash.fill").foregroundColor(.white)
                                .frame(width: 20, height: 20)
                                .padding(8).background(Color.red.opacity(0.7))
                                .cornerRadius(20)
                                .shadow(color: Color.black,radius: 8, x: 0, y: 5)
                        }
                        .alert("Are You sure You want to delete this playlist ?", isPresented: $viewModel.showAlert) {
                            Button("Delete", role: .destructive) {
                                viewModel.deletePlaylist(action: {navigationStack.pop()}())
                            }
                            Button("cancel", role: .cancel) { }
                        }
                )
                
            }
        }
        
    }
    
}

