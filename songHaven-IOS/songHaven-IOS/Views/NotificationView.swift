//
//  NotificationView.swift
//  songHaven-IOS
//
//  Created by SongH on 26/11/2022.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        ZStack{
            Button(action: {
                self.send()
                
            }){
                Text("send Notification")
            }
        }
        
        
    }
    
    func send (){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound,.badge]){
            (_ ,_ ) in
            
        }
        let content = UNMutableNotificationContent()
        content.title = "Message"
        content.body = "New band created"
        let open = UNNotificationAction(identifier : "open", title:"Open", options: .foreground)
        let cancel = UNNotificationAction(identifier : "cancel", title:"Cancel", options: .destructive)
   
        
        let categories = UNNotificationCategory(identifier: "action", actions: [open,cancel], intentIdentifiers: [])
        UNUserNotificationCenter.current().setNotificationCategories([categories])
        content.categoryIdentifier = "action"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5 , repeats: false)
        let req = UNNotificationRequest(identifier: "req", content: content , trigger: trigger)
        UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
        
    }
}
    struct NotificationView_Previews: PreviewProvider {
        static var previews: some View {
            NotificationView()
        }
    }
    

