//
//  MessageBubble.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 9/12/2022.
//

import SwiftUI

struct MessageBubble: View {
    var message: TextMessage
    let deleteAction : () -> Void
    @State private var isTapped = false
    
    
    var body: some View {
        VStack(alignment: message.sender._id != UserSession.shared.currentUser?._id ? .leading : .trailing) {
            if(isTapped){
                Text(message.sender.getFullName())
                    .foregroundColor(.gray)
                    .font(.caption2)
            }else{
                Rectangle()
                    .frame(width: 1,height: 12)
                    .opacity(0)
            }
            HStack(alignment: .top) {
                if(message.sender._id != UserSession.shared.currentUser?._id){
                    AsyncImage(url: URL(string: (UserService.UserImageUrl + message.sender.imageId!)))
                    {
                        Image in Image.resizable()
                    } placeholder: {
                        ProgressView()
                            .frame(width: 40, height: 40)
                    }
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .frame(width: 40,height: 40)
                }
                VStack(){
                    Text(message.text)
                        .foregroundColor(message.sender._id != UserSession.shared.currentUser?._id ? .white : .white)
                        .padding(10)
                        .background(message.sender._id != UserSession.shared.currentUser?._id ? Color(.gray) : Color.main_color)
                        .cornerRadius(30)
                        .contextMenu(menuItems: {
                            Group {
                                Button("Delete", role: .destructive ,action: {
                                    deleteAction()
                                })
                                .disabled(message.sender._id != UserSession.shared.currentUser?._id)
                            }
                        })
                    if isTapped {
                        Text("\(message.timestamp!.formatted(.dateTime.hour().minute()))")
                            .font(.caption2)
                            .foregroundColor(.gray)
                            .padding(message.sender._id != UserSession.shared.currentUser?._id ? .leading : .trailing, 25)
                    }else{
                        Rectangle()
                            .frame(width: 1,height: 12)
                            .opacity(0)
                    }
                }
            }
            .frame(maxWidth: 300, alignment: message.sender._id != UserSession.shared.currentUser?._id ? .leading : .trailing)
            .onTapGesture {
                isTapped.toggle()
            }
            
        }
        .frame(maxWidth: .infinity, alignment:message.sender._id != UserSession.shared.currentUser?._id ? .leading : .trailing)
        .padding(message.sender._id != UserSession.shared.currentUser?._id ? .leading : .trailing, 5)
    }
}

