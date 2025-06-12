//
//  NutrientDetail.swift
//  BuahHati
//
//  Created by Jose Andreas Lie on 09/06/25.
//

import Foundation
import SwiftData

@Model
public class NutrientDetail {
    public var id : UUID
    var nutrient : Nutrient
    var value : Int
    var uom : String
    
    init (nutrient : Nutrient, value : Int, uom : String) {
        self.id = UUID()
        self.nutrient = nutrient
        self.value = value
        self.uom = uom
    }
}
