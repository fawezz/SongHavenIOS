//
//  Profile.swift
//  songHaven-IOS
//
//  Created by Cyrine-Faouze on 7/11/2022.
//

import SwiftUI

struct ProfileView: View {
    @State var isPresented = false

    var body: some View {
        VStack {
            VStack {
                Header()
                ProfileText()
            }
            Spacer()
            Button (
                action: { self.isPresented = true },
                label: {
                    Label("Edit", systemImage: "pencil")
            })
        }.background(LinearGradient(gradient: .init(colors: [.black , .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
        
    }
    
}

struct ProfileText: View {
    var name = "Foulen Ben Foulen"
    var subtitle = "subtitle"
    var description = "description"
    
    var body: some View {
        VStack(spacing: 15) {
            VStack(spacing: 5) {
                Text(name)
                    .bold()
                    .font(.title)
                Text(subtitle)
                    .font(.body)
                    .foregroundColor(.secondary)
            }.padding()
            Text(description)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
    }
}
struct Header: View {
    static let gradientStart = Color(red: 216 / 255, green: 191 / 255, blue: 216 / 255)
    static let gradientEnd = Color(red: 101 / 255, green: 104 / 255, blue: 203 / 255)
    
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .fill(LinearGradient(
                      gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
                      startPoint: .init(x: 0.5, y: 0),
                      endPoint: .init(x: 0.5, y: 0.6)
                    ))
                .edgesIgnoringSafeArea(.top)
                .frame(height: 200)
            Image("userIcon")
                .resizable()
                .clipShape(Circle())
                .scaledToFit()
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .frame(width: 150,height: 150)
        }
    }
}
