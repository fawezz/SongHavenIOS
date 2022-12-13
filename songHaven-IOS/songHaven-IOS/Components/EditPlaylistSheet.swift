//
//  EditPlaylistSheet.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 4/12/2022.
//

import SwiftUI
import NavigationStack

struct EditPlaylistSheet: View {
    @ObservedObject var viewModel: EditPlaylistViewModel
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var languageService = LocalizationService.shared

    let emptySongList : [Song] = []
    var body: some View {
        ZStack{
            Color.black.opacity(0.8).edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Text("editPlaylistTxt1".localized(languageService.language))
                        .font(.title)
                        .foregroundColor(.main_color)
                    Spacer()
                    Button(action: {
                        viewModel.showCreationSheet = true
                    } ) {
                        Image(systemName: "plus.circle").foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .padding(8).background(Color.main_color)
                            .cornerRadius(20)
                            .shadow(color: Color.black,radius: 8, x: 0, y: 5)
                    }
                }
                ScrollView{
                    ForEach($viewModel.userPlaylists, id: \._id) { playlist in
                        HStack(){
                            Color.black.edgesIgnoringSafeArea(.all)
                            Text(playlist.title.wrappedValue ?? "default title")
                                .bold()
                                .foregroundColor(.purple)
                            Text((playlist.wrappedValue.songs?.count.description)! + "editPlaylistTxt2".localized(languageService.language))
                                .foregroundColor(.white)
                            Image(systemName:viewModel.songExists(songList: playlist.songs.wrappedValue ?? self.emptySongList) ? "checkmark.square" : "square")
                                .foregroundColor(.main_color)
                                .font(.system(size: 36))
                            
                        }
                        .frame(height: 50)
                        .padding(20)
                        .background(Color(.black))
                        .cornerRadius(20)
                        .padding(.horizontal, 6)
                        .onTapGesture {
                            let a = viewModel.addSongToPlaylist(selectedPlaylist: playlist.wrappedValue)
                            print(a)
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                
            }.padding()
            //LOADER
            if(viewModel.isLoading){
                ZStack{
                    Color(.white)
                        .opacity(0.3)
                        .ignoresSafeArea()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                        .scaleEffect(3)
                }
            }
        }.sheet(isPresented: $viewModel.showCreationSheet, onDismiss: {presentationMode.wrappedValue.dismiss()}){
            ZStack{
                Color.black.opacity(0.8).edgesIgnoringSafeArea(.all)
                VStack{
                    Text("editPlaylistTxt3".localized(languageService.language))
                        .font(.title3)
                        .foregroundColor(.main_color)
                        .padding(.all, 20)
                    
                    TextField("editPlaylistTxt4".localized(languageService.language), text: $viewModel.newPlaylistTitle)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .autocorrectionDisabled(true)
                        .padding()
                    
                    Button (
                        action: {
                            viewModel.createPlaylist()
                            viewModel.showCreationSheet = false
                        },
                        label: {
                            Text("editPlaylistTxt5".localized(languageService.language))
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 300, height: 50)
                                .background(viewModel.validateFields() ? Color.main_color : Color.gray)
                                .cornerRadius(15.0)
                        })
                    .padding(.vertical, 40)
                    .disabled(!viewModel.validateFields())
                }
            }
            .presentationDetents([.medium])
        }
    }
    
}
