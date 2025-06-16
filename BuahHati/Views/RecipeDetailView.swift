import SwiftUI

struct RecipeDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    let recipe: Recipe
    @State private var selectedTab: Tab = .recipes

    var body: some View {
        ZStack(alignment: .bottom) {
            Color("BackgroundColor").ignoresSafeArea()

            VStack(spacing: 0) {
                // Gambar
                Image(recipe.image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 220)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(80, corners: [.bottomLeft, .bottomRight])
                    .ignoresSafeArea(edges: .top)

                // Judul dan info waktu + porsi
                VStack(spacing: 12) {
                    Text(recipe.name)
                        .font(.title2)
                        .bold()

                    HStack(spacing: 24) {
                        HStack {
                            Image(systemName: "clock")
                                .foregroundColor(Color("PrimaryColor"))
                            Text("\(recipe.time) menit").foregroundColor(.gray)
                        }

                        HStack {
                            Image(systemName: "fork.knife")
                                .foregroundColor(Color("PrimaryColor"))
                            Text("\(recipe.portion) porsi").foregroundColor(.gray)
                        }
                    }
                    .font(.subheadline)
                }
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 32))
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 4)
                .offset(y: -120)

                // Nutrisi
                NutritionRow(items: recipe.nutrients.map {
                    ("\($0.value)\($0.uom)", $0.nutrient.name)
                })
                .padding(.bottom, 16)
                .padding(.top, -85)

                // Scrollable bagian bawah
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        IngredientSection(ingredients: recipe.ingredients.map(String.init))
                        StepSection(steps: recipe.details.enumerated().map {
                            StepItem(title: "Step \($0.offset + 1)", description: String($0.element))
                        })
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 42)
                    .padding(.top, 8)
                }
                .zIndex(0)
            }
            
            /*
            // Tab Bar
            ZStack(alignment: .bottom) {
                Color("PrimaryColor").ignoresSafeArea(edges: .bottom)
                    .padding(.top, 720)
                CustomTabBar(selectedTab: $selectedTab)
                    .padding(.bottom, -24)
            }
            */
        }
    }
}


#Preview {
    let sampleRecipe = Recipe(
        name: "Avocado Cake",
        ripeness: [.ripeFirstPhase],
        details: "Step 1|Step 2|Step 3",
        ingredients: "1 alpukat matang|220g butter|200g gula|4 butir telur|350g tepung|50ml susu",
        tools: "Oven|Mixer",
        difficulty: 2,
        time: 45,
        portion: 5,
        fruit: Fruit(name: "Avocado"),
        image: "Avocado Cake",
        nutrients: [
            NutrientDetail(nutrient: Nutrient(name: "Kalori"), value: 400, uom: "kal"),
            NutrientDetail(nutrient: Nutrient(name: "Protein"), value: 150, uom: "g"),
            NutrientDetail(nutrient: Nutrient(name: "Lemak"), value: 100, uom: "g"),
            NutrientDetail(nutrient: Nutrient(name: "Karbo"), value: 120, uom: "g")
        ]
    )

    return RecipeDetailView(recipe: sampleRecipe)
}

