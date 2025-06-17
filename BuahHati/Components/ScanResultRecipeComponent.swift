//
//  ScanResultRecipeComponent.swift
//  BuahHati
//
//  Created by Evan Lokajaya on 17/06/25.
//

import SwiftUI

struct ScanResultRecipeComponent: View {
    @State var recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(recipe.image)
                .resizable()
                .scaledToFill()
                .frame(width: 130, height: 90)
                .clipped()
                .cornerRadius(12)

            Text(recipe.name)
                .font(.headline)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .frame(height: 40, alignment: .topLeading)

            HStack(spacing: 4) {
                Image(systemName: "clock")
                Text("\(recipe.time) menit")
                    .font(.subheadline)
            }
            .foregroundColor(.gray)
        }
        .frame(width: 130)
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
    }
}

#Preview {
    let avocado = Fruit(name: "Avocado")
    
    let calories = Nutrient(name: "Kalori")
    let protein = Nutrient(name: "Protein")
    let fat = Nutrient(name: "Lemak")
    let carbs = Nutrient(name: "Karbohidrat")
    
    let recipe = Recipe(
        name: "Avocado Fries",
        ripeness: [.unripe, .breaking, .ripeFirstPhase],
        details: "Campurkan tepung roti, ketumbar, jintan, dan garam dalam mangkuk|Siapkan telur kocok pada mangkuk lain|Siapkan tepung terigu pada mangkuk lain|Potong alpukat secara memanjang|Celupkan setiap iris alpukat ke tepung, lalu telur, kemudian campuran tepung roti|Masak alpukat pada air fryer selama 15 menit pada suhu 200°C|Sajikan avocado fries dengan saus pilihan anda, sebaiknya dimakan ketika hangat",
        ingredients: "200g Tepung Roti|1 sdt Ketumbar|1 sdt Jintan|100g Tepung Terigu|2 Butir Telur|2 Buah Alpukat",
        tools: "Mangkuk|Air Fryer",
        difficulty: 3,
        time: 30,
        portion: 4,
        fruit: avocado,
        image: "AvocadoFries",
        nutrients: [
            NutrientDetail(nutrient: calories, value: 490, uom: "kal"),
            NutrientDetail(nutrient: protein, value: 14, uom: "g"),
            NutrientDetail(nutrient: fat, value: 24, uom: "g"),
            NutrientDetail(nutrient: carbs, value: 58, uom: "g")
        ]
    )
    ScanResultRecipeComponent(recipe: recipe)
}
