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
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: .init(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                VStack{
                    
                    Text("About The Band")
                        .bold()
                        .foregroundColor(.purple)
                        .font(.system(size: 34,weight: .light,design: .serif))
                    
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
                    
                    
                    
                } .navigationBarItems(leading: HStack(spacing: 140){
                    BackButton(action: {navigationStack.push(UserBandsView())})
                    Spacer()
                    Menu {
                        
                        Spacer( )
                        PushView(destination: EditBandView(), tag: "editBand", selection: $viewModel.navigator){}
                        Button(action: {
                            viewModel.navigator = "editBand"
                            
                        }) {
                            Label("Edit Band", systemImage: "pencil")
                        }
                        Button(action: {
                            // viewModel.criteria = "genre"
                        }) {
                            Label("Members", systemImage: "person.2.fill")
                        }
                        
                        PushView(destination: ArtistSuggestionView(viewModel: ArtistSuggetionViewModel(band: viewModel.selectedBand
                        )), tag: "artistSuggestion", selection: $viewModel.navigator){}
                        Button(action: {
                            
                            viewModel.navigator = "artistSuggestion"
                            
                        }) {
                            Label("Add Artist", systemImage: "person.fill.badge.plus")
                        }
                        
                        Button(
                            action: {
                                print("delete band")
                                viewModel.showAlert = true
                                
                            }, label:{
                                Label("Remove Band", systemImage: "trash")
                                    .frame(width: 20, height: 20)
                                    .padding(8).background(Color.red.opacity(0.7))
                                    .cornerRadius(20)
                                    .shadow(color: Color.black,radius: 8, x: 0, y: 5)
                            })
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
                    .alert("Are You sure You want to delete this band ?", isPresented: $viewModel.showAlert) {
                        Button("Delete", role: .destructive) {
                            
                            viewModel.deleteBand(action: {navigationStack.pop()}())
                        }
                        Button("cancel", role: .cancel) { }
                    }
                    .padding(.top)
                })
            }
        }
    }
    
}
