//
//  MemberView.swift
//  songHaven-IOS
//
//  Created by SongH on 10/12/2022.
//

import SwiftUI
import NavigationStack

struct MemberView: View {
    
    @StateObject var viewModel : BandDetailViewModel
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    
    var body: some View {
        NavigationStack{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .center){
                    
//                    if(viewModel.users.isEmpty){
//                        Text("No Artist added to band yet")
//                            .padding(.top, 20)
//                            .font(.title3)
//                            .foregroundColor(.gray.opacity(0.8))
//                    }else{
//                        List{
//                            ForEach($viewModel.users, id: \._id) { user in
//                                BandDetailViewModel(user: user.wrappedValue)
//                                    .padding(.horizontal, 3)
//                                    .onTapGesture {
//
//                                    }
//                                    .swipeActions(allowsFullSwipe: false) {
//                                        Button {
//                                            viewModel
//                                            (swipedSong: user.wrappedValue)
//                                            print("remove song")
//                                        } label: {
//                                            Label("remove", systemImage: "trash.fill")
//                                        }
//                                        .tint(.red.opacity(0.8))
//                                    }
//                                    .listRowSeparator(.hidden)
//                                    .listRowBackground(
//                                        Color.purple
//                                            .clipped()
//                                            .cornerRadius(20)
//                                            .padding(EdgeInsets(top: 15, leading: 25, bottom: 10, trailing: 25))
//                                    )
//                            }
                        }
                        .scrollContentBackground(.hidden)
                    }
                }
               
            }
            
        }
 
                    
