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
    var id : UUID
    var name : String
    var ripeness : [Ripeness]
    var details : [String]
    var ingredients : [String]
    var tools : [String]
    var difficulty : Int
    var time : Int // satuan menit
    var fruit : Fruit
    var image : String // BISA DIUBAH
    
    
    
    init(name: String, ripeness: [Ripeness], details: [String], ingredients: [String], tools: [String], difficulty: Int, time: Int, fruit: Fruit, image: String) {
        self.id = UUID()
        self.name = name
        self.ripeness = ripeness
        self.details = details
        self.ingredients = ingredients
        self.tools = tools
        self.difficulty = difficulty
        self.time = time
        self.fruit = fruit
        self.image = image
    }
}
