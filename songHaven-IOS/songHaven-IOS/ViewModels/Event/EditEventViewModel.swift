//
//  EditEventViewModel.swift
//  songHaven-IOS
//
//  Created by SongH on 20/12/2022.
//

import Foundation
@MainActor class EditEventViewModel: ObservableObject {
    @Published var title = ""
    @Published var description = ""
    @Published var longitud = ""
    @Published var latitud = ""
    

    @Published var navigator: String? = nil
    @Published var isLoading: Bool = false
    @Published var isUploading: Bool = false
    
    @Published var showSuccessToast : Bool = false
    @Published var showFailToast : Bool = false
    @Published var toastMessage = ""
    
    
    func EditDetails(){
        isLoading = true
        EventService.EditEvent(id: UserDefaults.standard.string(forKey: "eventId")!, title: title, description: description, longitud: longitud, latitud: latitud,  completed: { (success, reponse) in
            
            self.isLoading = false
            if success {
                print("success")
                let currentEvent = reponse as! Event
                UserDefaults.standard.setValue(
                    currentEvent.title,forKey: "title"
                )
                UserDefaults.standard.setValue(
                    currentEvent.description,forKey: "description"
                )
                UserDefaults.standard.setValue(
                    currentEvent.longitud,forKey: "longitud"
                )
                UserDefaults.standard.setValue(
                    currentEvent.latitud,forKey: "latitud"
                )
                self.toastMessage = "Success"
                self.showSuccessToast = true

            }
            else {
                self.toastMessage = reponse as! String
                self.showFailToast = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2){
                    self.showFailToast = false
                }
                print("fail")
            }
        })
    }
}
