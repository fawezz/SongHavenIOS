//
//  BandDetailView.swift
//  songHaven-IOS
//
//  Created by SongH on 21/11/2022.
//

import SwiftUI
import Foundation
import NavigationStack
struct BandDetailView: View {
    
    @StateObject var viewModel : BandDetailViewModel
    // @Published var showDeleteAlert : Bool = false
    @StateObject private var languageService = LocalizationService.shared
    
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: .init(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                VStack{
                    HStack(spacing: 0){
                        BackButton(action: {navigationStack.pop()})
                        Spacer()
                        Menu {
                            Button(action: {
                                navigationStack.push( EditBandView())
                            }) {
                                Label("EditBandtxt".localized(languageService.language), systemImage: "pencil")
                            }
                            Button(action: {
                                // viewModel.criteria = "genre"
                            }) {
                                Label("Members".localized(languageService.language), systemImage: "person.2.fill")
                            }
                            
                            Button(action: {
                                navigationStack.push(ArtistSuggestionView(viewModel: ArtistSuggetionViewModel(band: viewModel.selectedBand)))
                                viewModel.navigator = "artistSuggestion"
                                
                            }) {
                                Label("AddArtistTXT".localized(languageService.language), systemImage: "person.fill.badge.plus")
                            }
                            
                            Button(
                                action: {
                                    print("deleteband")
                                    viewModel.showAlert = true
                                    
                                }, label:{
                                    Label("deletebandTXT".localized(languageService.language), systemImage: "trash")
                                        .frame(width: 20, height: 20)
                                        .padding(8).background(Color.red.opacity(0.7))
                                        .cornerRadius(20)
                                        .shadow(color: Color.black,radius: 8, x: 0, y: 5)
                                })
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.clear)
                                    .frame(width: 40, height: 40)
                                Image(systemName: "ellipsis.circle")
                                    .rotationEffect(.degrees(-90))
                                    .foregroundColor(.white)
                                    .frame(width: 100, height: 100)
                                
                            }
                        }
                        .alert("Are You sure You want to delete this band ?".localized(languageService.language), isPresented: $viewModel.showAlert) {
                            Button("Delete".localized(languageService.language), role: .destructive) {
                                
                                viewModel.deleteBand(action: {navigationStack.pop()}())
                            }
                            Button("cancel".localized(languageService.language), role: .cancel) { }
                        }
                        .padding(.top)
                    }.padding()
                    HStack(){
                        Text("AboutTheBandTXT".localized(languageService.language))
                            .bold()
                            .foregroundColor(.white)
                            .font(.system(size: 30,weight: .light,design: .serif))
                        Spacer()
                        Button(action:
                                {
                            navigationStack.push(ChatView(viewModel: ChatViewModel(band: viewModel.selectedBand)))
                        }, label: {
                            Image(systemName: "message.fill")
                                .font(.system(size: 26))
                                .foregroundColor(.white)
                                .frame(width: 26, height: 26)
                                .padding(8).background(Color.main_color)
                                .cornerRadius(20)
                                .shadow(color: Color.black.opacity(0.8),radius: 8, x: 0, y: 5)
                      })
                    }.padding()
                    AsyncImage(url: URL(string: BandService.BandImageUrl + viewModel.selectedBand.image!))
                    {image in image.image?
                            .resizable()
                            .frame(width: 150, height: 150)
                    }
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 0))
                    .shadow(radius: 10)
                    .frame(width: 150,height: 150)
                    .shadow(radius: 10)
                    
                    VStack(spacing: 5) {
                        Text(viewModel.selectedBand.name! )
                            .font(.system(size: 25,weight: .light,design: .serif).italic())
                            .foregroundColor(.white)
                            .frame(alignment: .topTrailing)
                        
                        Text( viewModel.selectedBand.discription!)
                            .bold()
                            .foregroundColor(.white)
                        
                    }.padding()
                    
                    Text( "Membres".localized(languageService.language))
                        .bold()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    ScrollView{
                        if((viewModel.selectedBand.users) != nil){
                            Spacer()
                            Text("TxtMembre".localized(languageService.language))
                                .font(.title3)
                                .foregroundColor(.main_color)
                            Spacer()
                        }else{
                            List{
                                ForEach(viewModel.BandMember, id: \._id){ user in
                                    //  ProfileSongRow(user: user )
                                    // .listRowSeparator(.visible)
                                    //   .listRowBackground(
                                    Color.main_color
                                        .clipped()
                                        .cornerRadius(20)
                                        .padding(EdgeInsets(top: 15, leading: 25, bottom: 10, trailing: 25))
                                    
                                        .swipeActions(allowsFullSwipe: false) {
                                            Button {
                                                viewModel.showAlert = true
                                                print("remove member")
                                            } label: {
                                                Label("removeTxt".localized(languageService.language), systemImage: "trash.fill")
                                            }
                                            .tint(.red.opacity(0.8))
                                        }
                                        .alert("Are You sure You want to remove this member?".localized(languageService.language), isPresented: $viewModel.showAlert) {
                                            Button("DeleteTXt".localized(languageService.language), role: .destructive) {
                                                //viewModel.removeSong(swipedSong: song)
                                            }
                                            Button("cancel".localized(languageService.language), role: .cancel) { }
                                        }
                                }
                            }
                            .scrollContentBackground(.hidden)
                        }
                    }
                }
            }
            
            Spacer()
            
        }
    }
}
