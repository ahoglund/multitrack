//
//  MultiTrackApp.swift
//  MultiTrack
//
//  Created by Drew on 1/17/25.
//

import SwiftUI

@main
struct MultiTrackApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
