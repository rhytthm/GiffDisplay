//
//  GiffDisplayApp.swift
//  GiffDisplay
//
//  Created by Rhytthm on 17/08/22.
//

import SwiftUI

@main
struct GiffDisplayApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
