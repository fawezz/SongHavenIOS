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
        VStack(spacing: 0) {
            VStack {
                HStack(spacing: 20) {
                    BackButton(action: {
                        navigationStack.pop()
                    })
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
                            .foregroundColor(.white)
                        Text("Participants " + "\(viewModel.conversation.band?.users?.count.description ?? "")")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.leading, 10)
                .padding(.bottom, 5)
                //MyDivider()
            }
            .background(Color.main_color_hard)
            //end title row
            
            if(viewModel.conversation.messages.isEmpty){
                Text("No messages yet")
                    .foregroundColor(.white.opacity(0.5))
                    .padding(.vertical, 250)
            }
            ScrollViewReader { proxy in
                ScrollView {
                    ForEach(viewModel.conversation.messages, id: \.id) { message in
                        MessageBubble(message: message, deleteAction: {
                            viewModel.deleteMessage(tappedMessageId: message.id)
                        })
                    }
                }
                .padding(.vertical, 10)
                .background(Color.black.opacity(0.8))
                .onChange(of: viewModel.lastMessageId) { id in
                    // When the lastMessageId changes, scroll to the bottom of the conversation
                    withAnimation {
                        proxy.scrollTo(id, anchor: .bottom)
                    }
                }
            }
            //MyDivider()
            HStack {
                // Custom text field created below
                CustomTextField(placeholder: Text("Enter your message here"), text: $viewModel.messageField)
                    .frame(height: 52)
                    .disableAutocorrection(true)
                
                Button {
                    if(!viewModel.messageField.isEmpty)
                    {
                        viewModel.sendMessage()
                    }
                } label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.main_color)
                        .cornerRadius(50)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
            .background(Color.black.opacity(0.7))
            .cornerRadius(50)
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
        .background(Color.main_color_hard)
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
                    .foregroundColor(.white)
            }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
                .foregroundColor(.white)
        }
    }
}

struct MyDivider: View {
    let color: Material = Material.thick
    let width: CGFloat = 0.5
    var body: some View {
        Rectangle()
            .fill(color.opacity(0.7))
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

//                    Image(systemName: "phone.fill")
//                        .foregroundColor(.gray)
//                        .padding(10)
//                        .background(.white)
//                        .cornerRadius(50)
