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
    @State private var isloadingFile = false
    
    var body: some View {
        NavigationStack{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    TextField("title...", text: $viewModel.title)
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(20.0)
                        .autocorrectionDisabled(true)
                    TextField("genre...", text: $viewModel.genre)
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(20.0)
                        .autocorrectionDisabled(true)
                    
                    Button("select audio file") {
                        //self.isShowingFilePicker = true
                        self.isloadingFile = true
                    }
                    
                    
//                    FilePicker(types: [.mp3, .audio, .wav], allowMultiple: false, title: "pick single file") { urls in
//                        print("selected \(urls.count) files")
//                    }
                    Button(action: {
                        viewModel.publishSong()
                        //navigate to tthe next view
                        //self.selection = "home"
                    }) {
                        Text("Publish Song")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(buttonColor)
                            .cornerRadius(15.0)
                    }
                    .disabled(!viewModel.validateFields())
                }
                .padding(8)
                .navigationBarTitle("Add a new Song")
                //.navigationBarItems(leading: BackButton(action: {navigationStack.pop()}))
                .fileImporter(
                    isPresented: $isloadingFile,
                    allowedContentTypes: [.mp3, .audio],
                    allowsMultipleSelection: false
                ) { result in
                    do {
                        guard let selectedFile: URL = try result.get().first else { return }
                        viewModel.fileURL = selectedFile
                        print(viewModel.fileURL)
                    } catch {
                        // Handle failure.
                    }
                }
                
            }
        }
        
    }
    var buttonColor: Color{
        if(viewModel.validateFields()){
            return Color.green
        }else{
            return Color.gray
        }
    }
}

