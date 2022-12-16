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
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var languageService = LocalizationService.shared
    
    var body: some View {
        NavigationStack{
            VStack {
                VStack {
                    Header()
                    ProfileText()
                    VStack(spacing: 0){
                        HStack{
                            Spacer()
                            Divider().frame(height: 40)
                            ProfileSectionItem(title: "profileTxt1".localized(languageService.language), nbr: $viewModel.totalLikes.wrappedValue.description)
                            //ProfileSectionItem(title: "Albums", nbr: "10")
                            //Spacer()
                            Divider().frame(height: 40).foregroundColor(.main_color)
                            ProfileSectionItem(title: "profileTxt2".localized(languageService.language), nbr: $viewModel.userSongs.count.description)
                            Divider().frame(height: 40).foregroundColor(.main_color)
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
                        Label("profileTxt3".localized(languageService.language), systemImage: "pencil")
                    })
                .padding()
                PushView(destination: EditProfileView(), tag: "EditProfile", selection: $viewModel.navigator) {}
                
                    .navigationBarItems(trailing:
                    Menu {
                        Button(action: {
                            print("language Button")
                            viewModel.showLanguageSheet = true
                            
                        }) {
                            Label("ProfileOptions1".localized(languageService.language), systemImage: "character.book.closed.fill" )
                        }
                        Button(action: {
                            //logout
                            viewModel.showLogoutAlert = true
                        }) {
                            Label("ProfileOptions2".localized(languageService.language), systemImage: "xmark")
                        }
                    } label: {
                        ZStack{
                            Image(systemName: "ellipsis.circle")
                                .foregroundColor(.white)
                                .frame(width: 65, height: 65)
                        }
                    }
                        .alert("Are You sure You want Log out ?", isPresented: $viewModel.showLogoutAlert) {
                            Button("Log out", role: .destructive) {
                                navigationStack.push(LoginView())
                                viewModel.Logout()
                            }
                            Button("cancel", role: .cancel) { }
                        }
                                        /*Button(
                                         "Log out", action: {
                                         viewModel.showLogoutAlert = true
                                         }
                                         ).alert("Are You sure You want Log out ?", isPresented: $viewModel.showLogoutAlert) {
                                         Button("Log out", role: .destructive) {
                                         navigationStack.push(LoginView())
                                         viewModel.Logout()
                                         }
                                         Button("cancel", role: .cancel) { }
                                         }*/
                                        
                    )
            }.background(LinearGradient(gradient: .init(colors: [.black , .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
                .sheet(isPresented: $viewModel.showLanguageSheet, onDismiss: {presentationMode.wrappedValue.dismiss()}){
                    ZStack{
                        Color.black.opacity(0.8).edgesIgnoringSafeArea(.all)
                        VStack{
                            Text("languageSheetTxt1".localized(languageService.language))
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding(.all, 20)
                            Picker("languageSheetTxt1", selection: $viewModel.selectedLang) {
                                ForEach($viewModel.langs, id: \.self) {
                                    Text($0.wrappedValue)
                                        .foregroundColor(.white)
                                }
                            }.pickerStyle(.wheel)
                            Button (
                                action: {
                                    viewModel.applyChangeLang()
                                    viewModel.showLanguageSheet = false
                                    navigationStack.pop(to: .root)
                                },
                                label: {
                                    Text("languageSheetTxt2".localized(languageService.language))
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(width: 300, height: 50)
                                        .cornerRadius(15.0)
                                })
                            .padding(.vertical, 40)
                        }
                    }
                    .presentationDetents([.medium])
                }
                
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
                        .padding(.all, 50)
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
                    .rotation3DEffect(.degrees(20), axis: (x: 1, y: 0, z: 0))
            }.padding()
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
                .foregroundColor(.main_color)
        }
    }
}
