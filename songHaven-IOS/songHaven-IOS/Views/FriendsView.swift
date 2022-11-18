//
//  FriendsView.swift
//  songHaven-IOS
//
//  Created by cyrine on 18/11/2022.
//

import SwiftUI

struct FriendsView: View {
    @State private var nbrF = ""
    @State private var name = ""
    
    var body: some View {
        
        ZStack{
            LinearGradient(gradient: .init(colors: [.black, .purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack{
                
                Text("Friend & Groups")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                
                
                Spacer()
                VStack{
                    Spacer()
                    HStack{
                        Text("FRIEND")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 130, height: 50)
                            .background(Color.clear)
                            .cornerRadius(15.0)
                            .bold()
                        Text("REQUESTS")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 130, height: 50)
                            .background(Color.clear)
                            .cornerRadius(15.0)
                        Text("REQUESTS")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 130, height: 50)
                            .background(Color.clear)
                            .cornerRadius(15.0)
                        
                        
                    }
        
                    TextField("Search...",text:$name)
                        .padding()
                        .frame(width: 300, height :50)
                        .background(Color.white.opacity(0.35))
                        .cornerRadius(10)
                        .foregroundColor(.white)

                
                    
                }
                
                FriendRowItem()
                FriendRowItem()
                FriendRowItem()
                FriendRowItem()
            
                
                }
                
                
                
                
            }
        
            
        }
    }
    struct Register_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                FriendsView()
            }
            
            
        }
        
        
        
    }

struct FriendRowItem: View {
var body: some View {
    HStack{
    
        Image("User")
            .resizable()
            .clipShape(Circle())
            .scaledToFit()
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
            .frame(width: 50,height: 50)
        VStack{
            Text("Jean Paul")
                .bold()
                .foregroundColor(.white)
                .padding()
            
            Text("is Actice")
            
                .foregroundColor(.green)
              
                .padding()
        }
        Spacer()
        Button(role: .destructive, action: {}){
            Label("",systemImage: "trash")
        }
        
    }.padding(.all)
    

}
}


