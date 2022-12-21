//
//  CreateEventViewModel.swift
//  songHaven-IOS
//
//  Created by SongH on 20/12/2022.
//

import Foundation
@MainActor class CreateEventViewModel: ObservableObject {
    @Published var title = ""
    @Published public var dateEvent = Date ()
    @Published var description = ""
    @Published var latitude = ""
    @Published var longitud = ""
    @Published var isUploading: Bool = false
    @Published var isLoading: Bool = false
    @Published var navigator : String? = nil
    
    @Published var toastMessage = ""
    @Published var showSuccessToast : Bool = false
    @Published var showFailToast : Bool = false
    @Published var toastText: String = ""
    
    
    
    func AddEvent (){
        EventService.AddEvent(event: Event(title: title, description: description,latitud: latitude,longitud: longitud ), completed: { (success, reponse) in
            
            self.isLoading = false
            if success {
                self.toastText = "event created successfully"
                self.showSuccessToast = true
                print("success")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2){
                    self.navigator = "addEvent"
                    print("Event created successfully")
                    self.showSuccessToast = false
                }
            } else {
                self.toastText = "Add failed"
                self.showFailToast = true
                print("failure")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    self.showFailToast = false
                }
            }
        })
    }
    
    
    func validateFields()-> Bool{
        return (title.isEmpty || description.isEmpty)
    }
    
}

