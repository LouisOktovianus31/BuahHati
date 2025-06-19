//
//  ScanResultViewModel.swift
//  BuahHati
//
//  Created by Evan Lokajaya on 17/06/25.
//

import Foundation
import SwiftData

class ScanResultViewModel: ObservableObject {
    var ripeness: Ripeness
    var recipeController = RecipeController()
    
    var filteredRecipes: [Recipe] {
        let ripeness: [Ripeness] = [ripeness]
        let filteredData = recipeController.getRecipes(ripeness: ripeness)
        
        return filteredData
    }
    
    init(ripeness: Ripeness) {
        self.ripeness = ripeness
    }
    
    func setupModelContext(_ modelContext: ModelContext) {
        recipeController.setupModelContext(modelContext)
        objectWillChange.send()
    }
    
    func getImageName() -> String {
        return switch(ripeness) {
            case .unripe:
                "AvocadoUnripe"
            case .ripeFirstPhase:
                "AvocadoRipe"
            case .overripe:
                "AvocadoOverripe"
            default :
                "AvocadoRipe"
        }
    }
    
    func getRipenessDescription() -> String {
        return switch(ripeness) {
            case .unripe:
                "Likely to ripen in 3-4 days"
            case .ripeFirstPhase:
                "Likely to spoil in 3 days"
            case .overripe:
                "Likely to spoil in a day"
            default :
                "Likely to ripen in 3-4 days"
        }
    }
    
    func getRipenessCaption() -> String {
        return switch(ripeness) {
            case .unripe:
                "Let’s try these recipes, or you can keep it stored until it’s perfectly ripe!"
            case .ripeFirstPhase:
                "Yay! your avocado is just right. Perfect for eating it right away or cooking it."
            case .overripe:
                "Consume it soon while it’s still good. Let’s try these recipes before it’s too late!"
            default :
                "Let’s try these recipes, or you can keep it stored until it’s perfectly ripe!"
        }
    }
    
}
