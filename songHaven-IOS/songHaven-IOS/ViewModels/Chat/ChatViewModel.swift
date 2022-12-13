//
//  ChatViewModel.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 9/12/2022.
//
import Foundation
@MainActor class ChatViewModel: ObservableObject {
    
    var firstname = UserDefaults.standard.string(forKey: "firstname")!
    var lastname = UserDefaults.standard.string(forKey: "lastname")!
    
    @Published var band : Band
    @Published var message = ""
    @Published var bandImageUrl: URL
    
    
    @Published private(set) var messages: [TextMessage] = []
    @Published private(set) var lastMessageId: String = ""
    
    
    @Published var navigator: String? = nil
    @Published var isLoading: Bool = true
    
    
    @Published var showSuccessToast : Bool = false
    @Published var showFailToast : Bool = false
    @Published var toastMessage = ""
    //@Published var email = ""

    init(band: Band){
        self.band = band
        self.bandImageUrl = URL(string: BandService.BandImageUrl + (band.image ?? "default"))!
        fetchMessages()
    }
    
    func fetchMessages(){
        
        isLoading = false
    }
    
    func getMessages() {
        
    }
    
    // Add a message in Firestore
    func sendMessage() {
       

    }
    
    func validateFields()-> Bool{
        return !message.isEmpty
    }
    

    
    
}
