//
//  songHaven_IOSApp.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 7/11/2022.
//

import SwiftUI

@main
struct songHaven_IOSApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
RegisterView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
