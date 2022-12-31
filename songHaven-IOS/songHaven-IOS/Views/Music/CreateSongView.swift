//
//  CreateSong.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 29/11/2022.
//

import SwiftUI
import NavigationStack
import MobileCoreServices

struct CreateSongView: View {
    @StateObject var viewModel = CreateSongViewModel()
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    @State private var isShowingFilePicker = false
    @State private var fileURL : URL?
    
    var body: some View {
        NavigationStack{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    VStack(alignment: .leading){
                        Button("select audio file") {
                            self.isShowingFilePicker = true
                        }
                        .sheet(isPresented: $isShowingFilePicker){
                            FilePicker(isShowing: self.$isShowingFilePicker, fileURL: self.$fileURL)
                        }
                    }
                }
                .padding(8)
                .navigationBarTitle("Add a new Song")
                //.navigationBarItems(leading: BackButton(action: {navigationStack.pop()}))
                
            }
        }
        
    }
}



