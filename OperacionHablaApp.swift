//
//  OperacionHablaApp.swift
//  OperacionHabla
//
//  Created by AJ Whitsell on 9/17/25.
//

import SwiftUI
import CoreData

@main
struct OperacionHablaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
