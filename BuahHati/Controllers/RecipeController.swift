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
        
        var predicates: [Predicate<Recipe>] = []
        
        if let isFavorite = isFavorite {
            let favoritePredicate = #Predicate<Recipe> { recipe in
                recipe.isFavorite == isFavorite
            }
            predicates.append(favoritePredicate)
        }
        
        if !searchText.isEmpty {
            let searchPredicate = #Predicate<Recipe> { recipe in
                recipe.name.localizedStandardContains(searchText)
            }
            predicates.append(searchPredicate)
        }
        
        var fetchDescriptor = FetchDescriptor<Recipe>()
        
        if !predicates.isEmpty {
            let combinedPredicate = predicates.reduce(predicates[0]) { result, predicate in
                #Predicate<Recipe> { recipe in
                    result.evaluate(recipe) && predicate.evaluate(recipe)
                }
            }
            fetchDescriptor.predicate = combinedPredicate
        }
        
        do {
            let recipes = try modelContext.fetch(fetchDescriptor)
            
            if let ripeness = ripeness {
                return recipes.filter { recipe in
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
}
