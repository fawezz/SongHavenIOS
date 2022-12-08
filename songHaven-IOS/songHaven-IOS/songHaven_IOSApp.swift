//
//  songHaven_IOSApp.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 7/11/2022.
//

import SwiftUI
import NavigationStack

@main
struct songHaven_IOSApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            //    TestView()
            //  EditProfileView()
            //  AddBandView()
            // LoginView()
            //  BandDetailView()
            // AddBandView()
            //  BandsView()
         NavigationStackView{
                UserBandsView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
