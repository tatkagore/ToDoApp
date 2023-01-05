//
//  ToDoAppApp.swift
//  ToDoApp
//
//  Created by Tatiana Simmer on 04/01/2023.
//

import SwiftUI

@main
struct ToDoAppApp: App {
    let persistenceController  = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

