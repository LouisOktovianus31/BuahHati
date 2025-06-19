//
//  RecipeListViewModel.swift
//  BuahHati
//
//  Created by Evan Lokajaya on 15/06/25.
//

import Foundation
import SwiftData

class RecipeListViewModel: ObservableObject {
    var recipeController = RecipeController()
    
    @Published var searchText: String = ""
    @Published var selectQuickFilterFavorite: Bool = false
    @Published var selectQuickFilterUnripe: Bool = false
    @Published var selectQuickFilterRipe: Bool = false
    @Published var selectQuickFilterOverripe: Bool = false
    
    var filteredRecipes: [Recipe] {
        var ripeness: [Ripeness] = []
        
        if selectQuickFilterUnripe {
            ripeness.append(.unripe)
        }
        
        if selectQuickFilterRipe {
            ripeness.append(.ripeFirstPhase)
        }
        
        if selectQuickFilterOverripe {
            ripeness.append(.overripe)
        }
        
        let ripenessList = ripeness.isEmpty ? nil : ripeness
        
        let filteredData = recipeController.getRecipes(
            ripeness: ripenessList,
            isFavorite: selectQuickFilterFavorite ? true : nil,
            searchText: searchText
        )
        return filteredData
    }
    
    func setupModelContext(_ modelContext: ModelContext) {
        recipeController.setupModelContext(modelContext)
        objectWillChange.send()
    }
    func toggleFavorite(for recipe: Recipe) {
        recipeController.toggleFavorite(for: recipe)
    }
    
    func toggleQuickFilterFavorite() {
        self.selectQuickFilterFavorite.toggle()
    }
    
    func toggleQuickFilterUnripe() {
        self.selectQuickFilterUnripe.toggle()
    }
    
    func toggleQuickFilterRipe() {
        self.selectQuickFilterRipe.toggle()
    }
    
    func toggleQuickFilterOverripe() {
        self.selectQuickFilterOverripe.toggle()
    }
    
}
