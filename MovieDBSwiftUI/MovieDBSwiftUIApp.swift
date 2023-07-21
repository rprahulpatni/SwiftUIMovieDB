//
//  MovieDBSwiftUIApp.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import SwiftUI

@main
struct MovieDBSwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MovieList()
            //ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
