//
//  ResultsViewComponent.swift
//  BuahHati
//
//  Created by Hendrik Nicolas Carlo on 16/06/25.
//

import SwiftUI

struct ResultsViewComponent: View {
    var label: String
    
    var localizedLabel: String {
        switch label {
        case "Belum":
            return "Unripe"
        case "Sudah":
            return "Ripe"
        case "Terlalu":
            return "Overripe"
        default:
            return ""
        }
    }

    var body: some View {
        ZStack{
            Image("Avocado\(localizedLabel)")
                .resizable()
                .frame(width: 130, height: 161)
                .zIndex(2)
                .offset(x: -135, y: -20)
                
            HStack(spacing: 10) {
                Color.clear
                    .frame(width: 100)
                VStack(alignment: .leading, spacing: 0) {
                    Text("It's likely to be,")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.white)
                    HStack{
                        Text(localizedLabel)
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        Spacer()
                    }
                }
                .padding(.bottom, 10)
                Image(systemName: "chevron.right.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 30)
            .frame(height: 140)
            .background(Color("PrimaryColor"))
            .cornerRadius(20)
        }
    }
}

#Preview {
    ResultsViewComponent(label: "Belum")
    ResultsViewComponent(label: "Sudah")
    ResultsViewComponent(label: "Terlalu")
}
