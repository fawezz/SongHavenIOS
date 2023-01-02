//
//  Profile.swift
//  songHaven-IOS
//
//  Created by Cyrine-Faouze on 7/11/2022.
//
import SwiftUI
import NavigationStack
import WebKit

struct WebView : UIViewRepresentable {
    
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
}

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var languageService = LocalizationService.shared
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    
    var body: some View {
        NavigationStack{
            ZStack {
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
                            Button (
                                action: {
                                    navigationStack.push(CreateSongView())
                                },
                                label: {
                                    Label("addSong".localized(languageService.language), systemImage: "plus.app")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .frame(width: 150, height: 50)
                                        .background(Color.main_color.opacity(0.7))
                                        .cornerRadius(15.0)
                                })
                            .padding(.top, 10)
                            if(viewModel.userSongs.isEmpty){
                                Spacer()
                                Text("noSongsYet".localized(languageService.language))
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
                                            .alert("areYouSureDeleteSong".localized(languageService.language), isPresented: $viewModel.showDeleteAlert) {
                                                Button("Delete".localized(languageService.language), role: .destructive) {
                                                    viewModel.removeSong(swipedSong: song)
                                                }
                                                Button("cancel".localized(languageService.language), role: .cancel) { }
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
                }.background(LinearGradient(gradient: .init(colors: [.black , .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
            }
            
        }.accentColor(.white)
    }
    
    struct Header: View {
        static let gradientStart = Color(red: 0 / 255, green: 0 / 255, blue: 0 / 255)
        static let gradientEnd = Color(red: 101 / 255, green: 104 / 255, blue: 203 / 255)
        @ObservedObject var viewModel = ProfileViewModel()
        @StateObject private var languageService = LocalizationService.shared
        @EnvironmentObject private var navigationStack: NavigationStackCompat
        @Environment(\.presentationMode) var presentationMode

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
                Menu {
                    Button(action: {
                        print("language Button")
                        viewModel.showLanguageSheet = true
                    }) {
                        Label("ProfileOptions1".localized(languageService.language), systemImage: "character.book.closed.fill" )
                    }
                    Button(action: {
                        viewModel.showWebView = true
                        print("terms Button")
                    }) {
                        Label("termsCnditions".localized(languageService.language), systemImage: "square.and.pencil" )
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
                            .rotationEffect(.degrees(-90))
                            .foregroundColor(.white)
                            .frame(width: 65, height: 65)
                    }
                }.offset(x: 150, y: -120)
                    .alert("areYouSureLogOut".localized(languageService.language), isPresented: $viewModel.showLogoutAlert) {
                        Button("logOut", role: .destructive) {
                            navigationStack.push(LoginView())
                            viewModel.Logout()
                        }
                        Button("cancel".localized(languageService.language), role: .cancel) { }
                    }
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
            .sheet(isPresented: $viewModel.showLanguageSheet){
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
            .sheet(isPresented: $viewModel.showWebView){
                ZStack{
                    WebView(request: URLRequest(url: URL(string: "https://generator.lorem-ipsum.info/terms-and-conditions")!))
                }
                .presentationDetents([.large])
            }
            //ADD TERMS WEB VIEW
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



//    .navigationBarItems(trailing:
//
//                        /*Button(
//                         "Log out", action: {
//                         viewModel.showLogoutAlert = true
//                         }
//                         ).alert("Are You sure You want Log out ?", isPresented: $viewModel.showLogoutAlert) {
//                         Button("Log out", role: .destructive) {
//                         navigationStack.push(LoginView())
//                         viewModel.Logout()
//                         }
//                         Button("cancel", role: .cancel) { }
//                         }*/
//
//    )
