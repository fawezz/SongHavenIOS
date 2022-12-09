//
//  ChatView.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 9/12/2022.
//

import SwiftUI
import NavigationStack

struct ChatView: View {
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    @StateObject var viewModel : ChatViewModel
    var body: some View {
        VStack {
            VStack {
                HStack(spacing: 20) {
                    AsyncImage(url: viewModel.bandImageUrl) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .cornerRadius(50)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    VStack(alignment: .leading) {
                        Text(viewModel.band.name!)
                            .font(.title).bold()
                        
                        Text("Online")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "phone.fill")
                        .foregroundColor(.gray)
                        .padding(10)
                        .background(.white)
                        .cornerRadius(50)
                }
                .padding()
            }
            //end title row
            ScrollViewReader { proxy in
                ScrollView {
                    ForEach(viewModel.messages, id: \.id) { message in
                        MessageBubble(message: message)
                    }
                }
                .padding(.top, 10)
                .background(.white)
                .cornerRadius(30) // Custom cornerRadius modifier added in Extensions file
                .onChange(of: viewModel.lastMessageId) { id in
                    // When the lastMessageId changes, scroll to the bottom of the conversation
                    withAnimation {
                        proxy.scrollTo(id, anchor: .bottom)
                    }
                }
            }
        }
        .background(Color("Peach"))
        
        HStack {
            // Custom text field created below
            CustomTextField(placeholder: Text("Enter your message here"), text: $viewModel.message)
                .frame(height: 52)
                .disableAutocorrection(true)
            
            Button {
                viewModel.sendMessage()
                viewModel.message = ""
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color("Peach"))
                    .cornerRadius(50)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color("Gray"))
        .cornerRadius(50)
        .padding()
    }
}


struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            // If text is empty, show the placeholder on top of the TextField
            if text.isEmpty {
                placeholder
                    .opacity(0.5)
            }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}
