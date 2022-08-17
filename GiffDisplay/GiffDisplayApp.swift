//
//  GiffDisplayApp.swift
//  GiffDisplay
//
//  Created by Rhytthm on 17/08/22.
//

import SwiftUI

@main
struct GiffDisplayApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
