//
//  Recipe.swift
//  BuahHati
//
//  Created by Jose Andreas Lie on 09/06/25.
//

import Foundation
import SwiftData

@Model
public class Recipe{
    public var id : UUID
    var name : String
    var ripeness : [Ripeness]
    var detailsRaw : String = ""
    var ingredientsRaw : String = ""
    var toolsRaw : String = ""
    var difficulty : Int
    var time : Int // satuan menit
    var portion: Int
    var fruit : Fruit
    var image : String // BISA DIUBAH
    var nutrients: [NutrientDetail]
    var isFavorite: Bool
    
    @Transient
    var details : [Substring] {
        get {
            return detailsRaw.split(separator: "|")
        }
    }
    
    @Transient
    var ingredients : [Substring] {
        get {
            return ingredientsRaw.split(separator: "|")
        }
    }
    
    @Transient
    var tools : [Substring] {
        get {
            return toolsRaw.split(separator: "|")
        }
    }
    
    init(name: String, ripeness: [Ripeness], details: String, ingredients: String, tools: String, difficulty: Int, time: Int, portion: Int, fruit: Fruit, image: String, nutrients: [NutrientDetail], isFavorite: Bool = false) {
        self.id = UUID()
        self.name = name
        self.ripeness = ripeness
        self.detailsRaw = details
        self.ingredientsRaw = ingredients
        self.toolsRaw = tools
        self.difficulty = difficulty
        self.time = time
        self.portion = portion
        self.fruit = fruit
        self.image = image
        self.nutrients = nutrients
        self.isFavorite = isFavorite
    }
}
