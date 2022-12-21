//
//  DetailsEventViewModel.swift
//  songHaven-IOS
//
//  Created by SongH on 20/12/2022.
//

import Foundation
@MainActor class DetailEventViewModel : ObservableObject {
    @Published var selectedEvent : Event

    @Published var navigator : String? = nil
    @Published var showAlert = false
    
    init(selectedEvent: Event){
        
        self.selectedEvent = selectedEvent
    }
    
    func deleteEvent(action: ()){
        EventService.DeleteEvent(eventId: selectedEvent._id!, completed:
            { (success, reponse) in
            if(success){
                action
            }
        })
    }
    
}
  
