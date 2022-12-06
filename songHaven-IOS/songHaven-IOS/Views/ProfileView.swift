//
//  Profile.swift
//  songHaven-IOS
//
//  Created by Cyrine-Faouze on 7/11/2022.
//
import SwiftUI
import NavigationStack

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    
    var body: some View {
        NavigationStack{
            VStack {
                VStack {
                    Header()
                    ProfileText()
                    VStack(spacing: 0){
                        HStack{
                            Spacer()
                            ProfileSectionItem(title: "Likes", nbr: $viewModel.totalLikes.wrappedValue.description)
                            //ProfileSectionItem(title: "Albums", nbr: "10")
                            //Spacer()
                            ProfileSectionItem(title: "Songs", nbr: $viewModel.userSongs.count.description)
                            Spacer()
                        }
                        if(viewModel.userSongs.isEmpty){
                            Spacer()
                            Text("You don't have any songs yet")
                                .font(.title3)
                                .foregroundColor(.main_color)
                            Spacer()
                        }else{
                            List{
                                ForEach(viewModel.userSongs, id: \._id){ song in
                                    ProfileSongRow(song: song )
                                        .listRowSeparator(.visible)
                                        .listRowBackground(
                                            Color.main_color
                                                .clipped()
                                                .cornerRadius(20)
                                                .padding(EdgeInsets(top: 15, leading: 25, bottom: 10, trailing: 25))
                                        )
                                        .swipeActions(allowsFullSwipe: false) {
                                            Button {
                                                viewModel.showDeleteAlert = true
                                                print("remove song")
                                            } label: {
                                                Label("remove", systemImage: "trash.fill")
                                            }
                                            .tint(.red.opacity(0.8))
                                        }
                                        .alert("Are You sure You want to delete this song?", isPresented: $viewModel.showDeleteAlert) {
                                            Button("Delete", role: .destructive) {
                                                viewModel.removeSong(swipedSong: song)
                                            }
                                            Button("cancel", role: .cancel) { }
                                        }
                                }
                            }
                            .scrollContentBackground(.hidden)
                        }
                    }
                }
                Spacer()
                Button (
                    action: {
                        viewModel.navigator = "EditProfile"
                    },
                    label: {
                        Label("Edit Profile", systemImage: "pencil")
                    })
                PushView(destination: EditProfileView(), tag: "EditProfile", selection: $viewModel.navigator) {}
                
                    .navigationBarItems(trailing:  Button(
                        "Log out", action: {
                            viewModel.showLogoutAlert = true
                        }
                    ).alert("Are You sure You want Log out ?", isPresented: $viewModel.showLogoutAlert) {
                        Button("Log out", role: .destructive) {
                            viewModel.Logout()
                            navigationStack.push(LoginView())
                        }
                        Button("cancel", role: .cancel) { }
                    }
                    )
            }.background(LinearGradient(gradient: .init(colors: [.black , .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
        }.accentColor(.white)
    }
    
    struct Header: View {
        static let gradientStart = Color(red: 0 / 255, green: 0 / 255, blue: 0 / 255)
        static let gradientEnd = Color(red: 101 / 255, green: 104 / 255, blue: 203 / 255)
        @ObservedObject var viewModel = ProfileViewModel()
        
        var body: some View {
            ZStack(alignment: .center) {
                Rectangle()
                    .fill(LinearGradient(
                        gradient: .init(colors: [ Self.gradientStart, .purple]),
                        startPoint: .init(x: 0.5, y: 0),
                        endPoint: .init(x: 0.5, y: 0.6)
                    ))
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 200)
                AsyncImage(url:viewModel.profileImageUrl)
                {
                    Image in Image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .frame(width: 180,height: 180)
            }
        }
    }
    
    struct ProfileText: View {
        @ObservedObject var viewModel = ProfileViewModel()
        
        var body: some View {
            VStack(spacing: 15) {
                    Text(viewModel.firstname + " " + viewModel.lastname)
                        .bold()
                        .font(.title)
                        .foregroundColor(.white)
                        .rotation3DEffect(.degrees(30), axis: (x: 1, y: 0, z: 0))
                }.padding()
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.main_color, lineWidth: 0.5)
            )
        }
    }
}


struct ProfileSectionItem: View {
    var title : String
    var nbr : String
    var body: some View {
        VStack(spacing: 0){
            Text(nbr)
                .font(.headline)
                .bold()
                .foregroundColor(.white)
            Text(title)
                .font(.caption2)
                .foregroundColor(.white)
        }
    }
}
