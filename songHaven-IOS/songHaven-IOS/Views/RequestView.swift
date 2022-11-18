//
//  RequestView.swift
//  songHaven-IOS
//
//  Created by cyrine on 18/11/2022.
//

import SwiftUI

struct RequestView: View {
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
                        Text("FRIENDS")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 130, height: 50)
                            .background(Color.clear)
                            .cornerRadius(15.0)
                        Text("GROUPES")
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
                            .bold()
                        
                        
                    }
        
                    TextField("Search...",text:$name)
                        .padding()
                        .frame(width: 300, height :50)
                        .background(Color.white.opacity(0.15))
                        .cornerRadius(10)
                
                    
                }
                
               
                RequestRowItem()
                RequestRowItem()
                RequestRowItem()
                RequestRowItem()
                RequestRowItem()
                }
                
                
                
                
            }
        
    }
}

struct RequestView_Previews: PreviewProvider {
    static var previews: some View {
        RequestView()
    }
}
struct RequestRowItem: View {
    var body: some View {
        HStack{
            
            Image("User")
                .resizable()
                .clipShape(Circle())
                .scaledToFit()
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .frame(width: 50,height: 50)
            
                Text("Jean Paul")
                    .bold()
                    .foregroundColor(.white)
                    .padding()
            
            
            
            Spacer()
            
        } .padding(.all)
    }
    
}

