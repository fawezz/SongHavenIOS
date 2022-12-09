//
//  MessageBubble.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 9/12/2022.
//

import SwiftUI

struct MessageBubble: View {
    var message: Message
    @State private var showTime = false
    
    
    var body: some View {
        VStack(alignment: message.sender._id != UserSession.shared.currentUser?._id ? .leading : .trailing) {
            HStack {
                Text(message.text)
                    .padding()
                    .background(message.sender._id != UserSession.shared.currentUser?._id ? Color("Gray") : Color("Peach"))
                    .cornerRadius(30)
            }
            .frame(maxWidth: 300, alignment: message.sender._id != UserSession.shared.currentUser?._id ? .leading : .trailing)
            .onTapGesture {
                showTime.toggle()
            }
            
            if showTime {
                Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(message.sender._id != UserSession.shared.currentUser?._id ? .leading : .trailing, 25)
            }
        }
        .frame(maxWidth: .infinity, alignment:message.sender._id != UserSession.shared.currentUser?._id ? .leading : .trailing)
        .padding(message.sender._id != UserSession.shared.currentUser?._id ? .leading : .trailing)
        .padding(.horizontal, 10)
    }
}

