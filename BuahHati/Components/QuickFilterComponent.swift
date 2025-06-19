//
//  QuickFilterComponent.swift
//  BuahHati
//
//  Created by Evan Lokajaya on 15/06/25.
//

import SwiftUI

struct QuickFilterComponent: View {
    var symbol: String?
    var title: String
    @Binding var isSelected: Bool
    
    var body: some View {
        HStack {
            if let symbol = symbol {
                Image(systemName: symbol)
                    .foregroundStyle(isSelected ? Color("BackgroundColor") : Color("PrimaryColor"))
            }
            Text(title)
                .foregroundStyle(isSelected ? Color("BackgroundColor") : Color("PrimaryColor"))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            Capsule()
                .fill(isSelected ? Color("PrimaryColor") : Color("BackgroundColor"))
        )
        .overlay(
            Capsule()
                .stroke(Color("PrimaryColor"), lineWidth: 1)
        )
    }
}

#Preview {
    @Previewable @State var selected = true
    @Previewable @State var notSelected = false
    QuickFilterComponent(symbol: "heart.fill", title: "Favorite", isSelected: $selected)
    QuickFilterComponent(symbol: "heart.fill", title: "Favorite", isSelected: $notSelected)
    QuickFilterComponent(symbol: nil, title: "Belum Matang", isSelected: $notSelected)
    QuickFilterComponent(symbol: nil, title: "Matang", isSelected: $selected)
    QuickFilterComponent(symbol: nil, title: "Terlalu Matang", isSelected: $notSelected)
}
