//
//  BuahHatiApp.swift
//  BuahHati
//
//  Created by Louis Oktovianus on 09/06/25.
//

import SwiftUI
import SwiftData

@main
struct BuahHatiApp: App {
    
    let modelContainer: ModelContainer = {
        let schema = Schema([Fruit.self, Nutrient.self, NutrientDetail.self, Recipe.self, StorageInstruction.self])
        
        let modelConfiguration = ModelConfiguration(schema: schema)

        do {
            return try ModelContainer(for: schema)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(modelContainer)
    }
}
