//
//  CreateSong.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 29/11/2022.
//

import SwiftUI
import NavigationStack
import MobileCoreServices
import FilePicker

struct CreateSongView: View {
    @StateObject var viewModel = CreateSongViewModel()
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    @State private var isShowingFilePicker = false
    @State private var isloadingFile = false
    @State private var fileURL : URL?
    
    @State private var document: MessageDocument = MessageDocument(message: "Hello, World!")
    var body: some View {
        NavigationStack{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    VStack(alignment: .leading){
                        Button("select audio file") {
                            //self.isShowingFilePicker = true
                            self.isloadingFile = true
                        }
//                        .sheet(isPresented: $isShowingFilePicker){
//                            //FilePicker(isShowing: self.$isShowingFilePicker, fileURL: self.$fileURL)
//                        }
                        
                    }
                    FilePicker(types: [.plainText], allowMultiple: true ) { urls in
                                    print("selected \(urls.count) files")
                                } label: {
                                    HStack {
                                        Image(systemName: "doc.on.doc")
                                        Text("Pick Files")
                                    }
                                }
                                
                                FilePicker(types: [.plainText], allowMultiple: false, title: "pick single file") { urls in
                                    print("selected \(urls.count) files")
                                }
                }
                .padding(8)
                .navigationBarTitle("Add a new Song")
                //.navigationBarItems(leading: BackButton(action: {navigationStack.pop()}))
                .fileImporter(
                    isPresented: $isloadingFile,
                    allowedContentTypes: [.plainText],
                    allowsMultipleSelection: false
                ) { result in
                    do {
                        guard let selectedFile: URL = try result.get().first else { return }
                        guard let message = String(data: try Data(contentsOf: selectedFile), encoding: .utf8) else { return }

                        document.message = message
                    } catch {
                        // Handle failure.
                    }
                }
                
            }
        }
        
    }
}


import UniformTypeIdentifiers

struct MessageDocument: FileDocument {
    
    static var readableContentTypes: [UTType] { [.plainText] }

    var message: String

    init(message: String) {
        self.message = message
    }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        message = string
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: message.data(using: .utf8)!)
    }
    
}
