//
//  CreateSong.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 29/11/2022.
//

import SwiftUI
import NavigationStack

struct CreateSongView: View {
    @StateObject var viewModel : CreateSongViewModel
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    var body: some View {
        NavigationStack{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    VStack(alignment: .leading){
                        Button("", action: {
                            //viewModel.documentPicker.delegate = self
                            //viewModel.documentPicker.modalPresentationStyle = .overFullScreen
                        })
                        
                    }
                }
                .padding(8)
                .navigationBarTitle("Add a new Song")
                .navigationBarItems(leading: BackButton(action: {navigationStack.pop()}))
                
            }
        }
        
    }
}



