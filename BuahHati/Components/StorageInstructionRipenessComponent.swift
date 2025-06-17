//
//  StorageInstructionRipenessComponent.swift
//  BuahHati
//
//  Created by Jose Andreas Lie on 17/06/25.
//

import SwiftUI

struct StorageInstructionRipenessComponent: View {
//    let ripeness: String
//    var imageName: String {
//        switch ripeness.lowercased() {
//        case "unripe":
//            return "StorageInstruction-Ripe"
//        case "ripe":
//            return "RipeImage"
//        case "overripe":
//            return "OverripeImage"
//        default:
//            return "DefaultImage"
//        }
//    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            // Image
            Image("StorageInstruction-Ripe")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 112, height: 112)
            
            // Content
            VStack(alignment: .leading, spacing: 12) {
                // Title
                Text("Belum Matang")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // Characteristics
                VStack(alignment: .leading, spacing: 4) {
                    Text("• Warna kulit hijau cerah")
                        .font(.body)
                        .foregroundColor(.black)
                    Text("• Tekstur keras saat ditekan")
                        .font(.body)
                        .foregroundColor(.black)

//                    ForEach(characteristics, id: \.self) { characteristic in
//                        Text(characteristic)
//                            .font(.body)
//                            .foregroundColor(.black)
//                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .padding(16)
        .background(Color(red: 0.83, green: 0.88, blue: 0.74))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    StorageInstructionRipenessComponent()
}
