//
//  HTS.swift
//  BuahHati
//
//  Created by Jose Andreas Lie on 09/06/25.
//

import Foundation
import SwiftData

@Model
public class StorageInstruction {
    public var id : UUID
    var fruit : Fruit
    var ripeness : Ripeness
    var isOpen : Bool
    var instructions : [String] = []
    
    init (fruit: Fruit, ripeness: Ripeness, isOpen: Bool, instructions : [String]) {
        self.id = UUID()
        self.fruit = fruit
        self.ripeness = ripeness
        self.isOpen = isOpen
        self.instructions = instructions
    }
}
