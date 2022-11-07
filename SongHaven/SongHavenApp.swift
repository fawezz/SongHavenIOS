//
//  SongHavenApp.swift
//  SongHaven
//
//  Created by fawez on 7/11/2022.
//

import SwiftUI

@main
struct SongHavenApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
