//
//  Profile.swift
//  songHaven-IOS
//
//  Created by Cyrine-Faouze on 7/11/2022.
//
import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                VStack {
                    Header()
                    ProfileText()
                    
                    VStack{
                        HStack{
                            ProfileSectionItem(title: "Likes", nbr: "1111")
                            Spacer()
                            ProfileSectionItem(title: "Albums", nbr: "10")
                            Spacer()
                            ProfileSectionItem(title: "Songs", nbr: "57")
                        }
                        SongRowItem()
                        SongRowItem()
                        SongRowItem()
                        SongRowItem()
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
                NavigationLink(destination: EditProfileView(), tag: "EditProfile", selection: $viewModel.navigator){}
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
        
        var  songName = ""
        var description = "description"
        
        var body: some View {
            VStack(spacing: 15) {
                VStack(spacing: 5) {
                    Text(viewModel.firstname + " " + viewModel.lastname)
                        .bold()
                        .font(.title)
                        .foregroundColor(.white)
                }.padding()
            }
            
        }
    }
    
    struct ProfileView_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                ProfileView()
            }
        }
    }
}


struct SongRowItem: View {
    var body: some View {
        HStack{
            Image("logo")
                .resizable()
                .clipShape(Circle())
                .scaledToFit()
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .frame(width: 50,height: 50)
            
            Spacer()
            Text("EarthSong")
                .bold()
                .foregroundColor(.white)
                .padding()
        }
    }
}

struct ProfileSectionItem: View {
    var title : String
    var nbr : String
    var body: some View {
        VStack{
            Text(nbr)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .padding()
            Text(title)
                .bold()
                .foregroundColor(.white)
                .padding()
            
        }
    }
}
