//
//  Nutrient.swift
//  BuahHati
//
//  Created by Jose Andreas Lie on 09/06/25.
//

import Foundation
import SwiftData

public class Nutrient {
    var id : UUID
    var name : String
    
    init (name : String) {
        self.id = UUID()
        self.name = name
    }
}
