//
//  StorageInstructionsController.swift
//  BuahHati
//
//  Created by Evan Lokajaya on 12/06/25.
//

import Foundation
import SwiftData

class StorageInstructionsController {
    var modelContext: ModelContext?
    
    func setupModelContext(_ modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func getStorageInstructions(ripeness: [Ripeness]? = nil, isOpen: Bool? = nil) -> [StorageInstruction] {
        guard let modelContext = modelContext else {
            print("Model Context not set: Get Storage Instructions Data")
            return []
        }
        
        var fetchDescriptor = FetchDescriptor<StorageInstruction>()
        
        if let isOpen = isOpen {
            fetchDescriptor.predicate = #Predicate<StorageInstruction> { instruction in
                instruction.isOpen == isOpen
            }
        }
        
        do {
            let storageInstructions = try modelContext.fetch(fetchDescriptor)
            
            if let ripeness = ripeness {
                return storageInstructions.filter { item in
                    ripeness.contains(item.ripeness)
                }
            }
            
            return storageInstructions
        } catch {
            print("Failed to fetch storage instructions: \(error)")
            return []
        }
    }
}
