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
    @StateObject private var languageService = LocalizationService.shared
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    @State private var isShowingFilePicker = false
    @State private var isloadingFile = false
    
    var body: some View {
        NavigationStack{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 15){
                    HStack(){
                        Text("title".localized(languageService.language) + ":")
                            .font(.headline)
                        Spacer()
                    }
                    TextField("title".localized(languageService.language) + "...", text: $viewModel.title)
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(20.0)
                        .autocorrectionDisabled(true)
                    HStack{
                        Text("genre".localized(languageService.language) + ":")
                            .font(.headline)
                        Spacer()
                    }
                    TextField("genre".localized(languageService.language) + "...", text: $viewModel.genre)
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(20.0)
                        .autocorrectionDisabled(true)
                    
                    Button(
                        action: {
                            self.isloadingFile = true
                        },
                        label: {
                            Label("selectAudioFile".localized(languageService.language), systemImage: "doc.circle")
                                .cornerRadius(15.0)
                        })
                    Button(action: {
                        viewModel.publishSong()
                        navigationStack.pop()
                        //navigate to tthe next view
                        //self.selection = "home"
                    }, label: {
                        Text("publishSong".localized(languageService.language))
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(buttonColor)
                            .cornerRadius(15.0)
                    })
                    .disabled(!viewModel.validateFields())
                    .padding(.vertical, 25)
                }
                .padding(10)
                .navigationBarTitle("addNewSong".localized(languageService.language)).foregroundColor(.white)
                .navigationBarItems(leading: BackButton(action: {navigationStack.pop()}))
                .fileImporter(
                    isPresented: $isloadingFile,
                    allowedContentTypes: [.mp3, .audio],
                    allowsMultipleSelection: false
                ) { result in
                    do {
                        guard let selectedFile: URL = try result.get().first else { return }
                        viewModel.fileURL = selectedFile
                        //print(viewModel.fileURL)
                    } catch {
                        print(error)
                        // Handle failure.
                    }
                }
                //LOADER
                if(viewModel.isUploading){
                    ZStack{
                        Color(.white)
                            .opacity(0.7)
                            .ignoresSafeArea()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                            .scaleEffect(3)
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

