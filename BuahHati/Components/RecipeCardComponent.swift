//
//  RecipeCardComponent.swift
//  BuahHati
//
//  Created by Evan Lokajaya on 13/06/25.
//

import SwiftUI

struct RecipeCardComponent: View {
    var recipe: Recipe

    var body: some View {
        HStack(spacing: 0) {
            Image(recipe.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 120)
                .clipped()
            VStack(alignment: .leading, spacing: 5) {
                Text(recipe.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                HStack {
                    Text("🕘")
                        .font(.caption)
                    Text("\(recipe.time) Minutes")
                        .font(.caption)
                }
                .padding(.leading)
                HStack {
                    Text("🔥")
                        .font(.caption)
                    if (recipe.difficulty >= 1 && recipe.difficulty < 3) {
                        Text("Easy")
                            .font(.caption)
                    }
                    else if (recipe.difficulty >= 2 && recipe.difficulty < 5) {
                        Text("Intermediate")
                            .font(.caption)
                    }
                    else {
                        Text("Hard")
                            .font(.caption)
                    }
                }
                .padding(.leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding(.vertical, 20)
            .background(Color("CardBackgroundColor"))
        }
    }
}

#Preview {
    let avocado = Fruit(name: "Avocado")
    
    let calories = Nutrient(name: "Kalori")
    let protein = Nutrient(name: "Protein")
    let fat = Nutrient(name: "Lemak")
    let carbs = Nutrient(name: "Karbohidrat")
    
    let recipe = Recipe(
        name: "Avocado Pickles",
        ripeness: [.unripe, .breaking],
        details: "Campurkan cuka, air, gula, dan garam ke dalam panci|Didihkan sambil diaduk hingga gula dan garam larut|Angkat cairan cuka dan diamkan hingga mencapai suhu ruang|Potong alpukat secara memanjang|Masukkan bawang putih, potongan cabai, alpukat, dan campuran larutan asam ke dalam wadah tertutup|Pastikan alpukat terendam larutan asam|Diamkan di kulkas minimal 2 jam sebelum dikonsumsi|Avocado Pickle dapat bertahan hingga satu minggu di dalam kulkas",
        ingredients: "240ml Cuka Putih|240ml Air|50g Gula Pasir|Bawang Putih Iris|Cabai Iris|2 Buah Alpukat",
        tools: "Panci|Wadah Tertutup",
        difficulty: 1,
        time: 15,
        portion: 4,
        fruit: avocado,
        image: "AvocadoPickle",
        nutrients: [
            NutrientDetail(nutrient: calories, value: 115, uom: "kal"),
            NutrientDetail(nutrient: protein, value: 1, uom: "g"),
            NutrientDetail(nutrient: fat, value: 15, uom: "g"),
            NutrientDetail(nutrient: carbs, value: 11, uom: "g")
        ]
    )
    RecipeCardComponent(recipe: recipe)
}
