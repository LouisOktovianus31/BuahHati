import SwiftUI

struct ResultViewUnripe: View {
    let recipes: [Recipe]

    @State private var isShowingRecipeList = false

    var filteredRecipes: [Recipe] {
        recipes.filter { $0.ripeness.contains(.unripe) }
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Color("BackgroundColor").ignoresSafeArea()

                VStack(spacing: 0) {
                    // MARK: Wave Header
                    ZStack {
                        WaveShape()
                            .fill(Color("PrimaryColor"))
                            .frame(height: 380)
                            .ignoresSafeArea(edges: .top)

                        VStack(spacing: 12) {
                            HStack {
                                Button(action: {
                                    // Handle back
                                }) {
                                    Image(systemName: "arrow.left")
                                        .font(.title2)
                                        .foregroundColor(.black)
                                        .padding(.leading, 16)
                                }
                                Spacer()
                            }
                            .padding(.top, -20)

                            Image("Avocado")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 110, height: 110)

                            Text("Belum Matang")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)

                            Text("Estimasi matang dalam 3–4 hari")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                    }

                    Spacer()

                    // MARK: Main Content
                    VStack(spacing: 20) {
                        Text("Wah, alpukat kamu belum siap nih. Tapi bisa ditunggu kok. Sambil nunggu, coba deh resep ini~ 🍽️")
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .fixedSize(horizontal: false, vertical: true)

                        Button(action: {}) {
                            Text("Cara menyimpan alpukat saya")
                                .underline()
                                .foregroundColor(Color("BrownColor"))
                        }

                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Resep")
                                    .font(.title3)
                                    .bold()

                                Spacer()

                                Button(action: {
                                    isShowingRecipeList = true
                                }) {
                                    Text("Lihat semua")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .underline()
                                }
                                .background(
                                    NavigationLink(
                                        destination: RecipeListView(recipes: filteredRecipes),
                                        isActive: $isShowingRecipeList
                                    ) {
                                        EmptyView()
                                    }
                                    .hidden()
                                )
                            }
                            .padding(.horizontal)

                            Text("yang bisa dicoba sambil menunggu alpukat matang")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.horizontal)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(filteredRecipes.prefix(3), id: \.id) { recipe in
                                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
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
                                        .buttonStyle(.plain)
                                    }
                                }
                                .padding(.leading, 16)
                                .padding(.trailing, 40)
                            }
                        }

                        Spacer()
                            .padding(.bottom, 110)
                    }
                    .padding(.top, -40)
                    .background(
                        Color("BackgroundColor")
                            .clipShape(RoundedCorner(radius: 40, corners: [.topLeft, .topRight]))
                    )
                }

                Spacer()

                // MARK: Bottom Tab
                HStack {
                    Spacer()
                    Image(systemName: "house.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "doc.text")
                        .font(.title2)
                        .foregroundColor(.white.opacity(0.5))
                    Spacer()
                    Image(systemName: "archivebox")
                        .font(.title2)
                        .foregroundColor(.white.opacity(0.5))
                    Spacer()
                }
                .padding(.bottom, 32)
                .padding(.vertical, 16)
                .background(Color("PrimaryColor"))
                .clipShape(RoundedCorner(radius: 0, corners: [.topLeft, .topRight]))
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: -2)
                .ignoresSafeArea(edges: .bottom)
            }
        }
    }
}

#Preview {
    let sampleFruit = Fruit(name: "Avocado")

    let sampleRecipes: [Recipe] = [
        Recipe(
            name: "Avocado Pickles",
            ripeness: [.unripe],
            details: "Step 1|Step 2|Step 3",
            ingredients: "Alpukat|Cuka|Bawang",
            tools: "Panci|Wadah",
            difficulty: 1,
            time: 20,
            portion: 3,
            fruit: sampleFruit,
            image: "AvocadoPickle",
            nutrients: [
                NutrientDetail(nutrient: Nutrient(name: "Kalori"), value: 80, uom: "kal"),
                NutrientDetail(nutrient: Nutrient(name: "Lemak"), value: 7, uom: "g"),
                NutrientDetail(nutrient: Nutrient(name: "Protein"), value: 1, uom: "g"),
                NutrientDetail(nutrient: Nutrient(name: "Karbo"), value: 5, uom: "g")
            ]
        ),
        Recipe(
            name: "Avocado Stir-Fry",
            ripeness: [.unripe],
            details: "Step 1|Step 2|Step 3",
            ingredients: "Alpukat|Ayam|Sayuran",
            tools: "Wok|Mangkuk",
            difficulty: 2,
            time: 35,
            portion: 4,
            fruit: sampleFruit,
            image: "AvocadoStirFry",
            nutrients: [
                NutrientDetail(nutrient: Nutrient(name: "Kalori"), value: 300, uom: "kal"),
                NutrientDetail(nutrient: Nutrient(name: "Lemak"), value: 18, uom: "g"),
                NutrientDetail(nutrient: Nutrient(name: "Protein"), value: 12, uom: "g"),
                NutrientDetail(nutrient: Nutrient(name: "Karbo"), value: 20, uom: "g")
            ]
        )
    ]

    return ResultViewUnripe(recipes: sampleRecipes)
}
