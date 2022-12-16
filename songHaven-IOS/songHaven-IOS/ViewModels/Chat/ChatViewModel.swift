//
//  ChatViewModel.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 9/12/2022.
//
import Foundation
import Combine
@MainActor class ChatViewModel: ObservableObject {
    
    var firstname = UserDefaults.standard.string(forKey: "firstname")!
    var lastname = UserDefaults.standard.string(forKey: "lastname")!
    
    @Published var band : Band
    @Published var messageField = ""
    @Published var bandImageUrl: URL
    
    
    //@Published private(set) var messages: [TextMessage] = [TextMessage]()
    @Published private(set) var conversation: Conversation = Conversation()
    @Published private(set) var lastMessageId: String = ""
    
    
    @Published var isLoading: Bool = true
    
    @Published var showSuccessToast : Bool = false
    @Published var showFailToast : Bool = false
    @Published var toastMessage = ""
    @Published var chatManager : SocketChatManager = SocketChatManager.shared
    var messageStream = SocketChatManager.shared.messageStream
    
    init(band: Band){
        self.band = band
        self.bandImageUrl = URL(string: BandService.BandImageUrl + (band.image ?? "default"))!
        fetchMessages()
        messageStream.subscribe(on: DispatchQueue.main).sink(receiveValue: { newTextMessage in
            if(newTextMessage.conversationId == self.conversation._id){
                self.conversation.messages.append(newTextMessage)
                self.lastMessageId = newTextMessage.id
                print("inside sink")
            }
        })
    }
    
    func fetchMessages(){
        ConversationService.GetConversationByBandId(bandId: self.band._id!, completed: { (success, conversation) in
            if(success){
                self.conversation = conversation!
                if(!(conversation?.messages.isEmpty)!){
                    self.lastMessageId = (conversation?.messages.last!.id)!
                }
            }else{
                print("error getting conversation")
            }
        })
        isLoading = false
    }
    func deleteMessage(tappedMessageId: String){
        ConversationService.DeleteMessage(textMessageId: tappedMessageId, completed: { (success, deletedTextMessageId) in
            if(success){
                self.conversation.messages.removeAll(where: {$0.id == deletedTextMessageId})
                if(self.lastMessageId == deletedTextMessageId && !self.conversation.messages.isEmpty){
                    self.lastMessageId = self.conversation.messages.last!.id
                }
            }else{
                print("error getting conversation")
            }
        })
        isLoading = false
    }
    
    func sendMessage() {
        let newTextMessage: TextMessage = TextMessage(
            id: "",
            text: messageField,
            sender: UserSession.shared.currentUser!,
            timestamp: nil,
            conversationId: self.conversation._id!
        )
        chatManager.sendMessage(textMessage: newTextMessage, roomId: (conversation.band?._id)!)
        self.messageField = ""
    }
    
    func validateFields()-> Bool{
        return !messageField.isEmpty
    }
    
    
    
}
