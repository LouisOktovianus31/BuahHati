//
//  RecipeController.swift
//  BuahHati
//
//  Created by Evan Lokajaya on 10/06/25.
//

import Foundation
import SwiftData

class RecipeController {
    var modelContext: ModelContext?
    
    func setupModelContext(_ modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func getRecipes(ripeness: [Ripeness]? = nil, isFavorite: Bool? = nil, searchText: String = "") -> [Recipe] {
        guard let modelContext = modelContext else {
            print("Model Context not set: Get Recipe Data")
            return []
        }
        
        // Fetch all recipes first
        let fetchDescriptor = FetchDescriptor<Recipe>(
            sortBy: [SortDescriptor(\.name)]
        )
        
        do {
            var recipes = try modelContext.fetch(fetchDescriptor)
            
            // Filter by favorite
            if let isFavorite = isFavorite {
                recipes = recipes.filter { $0.isFavorite == isFavorite }
            }
            
            // Filter by search text
            if !searchText.isEmpty {
                recipes = recipes.filter { recipe in
                    recipe.name.localizedCaseInsensitiveContains(searchText)
                }
            }
            
            // Filter by ripeness
            if let ripeness = ripeness, !ripeness.isEmpty {
                recipes = recipes.filter { recipe in
                    recipe.ripeness.contains { recipeRipeness in
                        ripeness.contains(recipeRipeness)
                    }
                }
            }
            
            return recipes
        } catch {
            print("Failed to fetch recipes: \(error)")
            return []
        }
    }
    
    func toggleFavorite(for recipe: Recipe) {
            guard let modelContext = modelContext else {
                print("Model Context not set: Toggle Favorite")
                return
            }
            
            recipe.isFavorite.toggle()
            
            do {
                try modelContext.save()
            } catch {
                print("Failed to save favorite status: \(error)")
                recipe.isFavorite.toggle()
            }
        }
}
