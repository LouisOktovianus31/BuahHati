import SwiftUI

struct ResultView: View {
    let ripenessTarget: Ripeness
    let recipes: [Recipe]

    @State private var isShowingRecipeList = false

    var filteredRecipes: [Recipe] {
        recipes.filter { $0.ripeness.contains(ripenessTarget) }
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Color("BackgroundColor").ignoresSafeArea()

                VStack(spacing: 0) {
                    // MARK: Hijau Atas dengan Wave
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

                            Text("Sudah Matang")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)

                            Text("Estimasi busuk dalam 3 hari")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                    }

                    Spacer()

                    // MARK: Section Putih
                    VStack(spacing: 20) {
                        Text("Yey! Alpukat kamu pas banget nih. Cocok buat langsung dimakan atau diolah~")
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

                            Text("sesuai kematangan alpukatmu")
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

    let sampleRecipeList: [Recipe] = [
        Recipe(
            name: "Guaga Mole",
            ripeness: [.ripeFirstPhase],
            details: "Step 1|Step 2|Step 3",
            ingredients: "Alpukat|Tomat|Bawang|Jeruk Nipis",
            tools: "Mangkok|Garpu",
            difficulty: 1,
            time: 30,
            portion: 2,
            fruit: sampleFruit,
            image: "HomescreenLogo",
            nutrients: [
                NutrientDetail(nutrient: Nutrient(name: "Kalori"), value: 120, uom: "kal"),
                NutrientDetail(nutrient: Nutrient(name: "Protein"), value: 4, uom: "g"),
                NutrientDetail(nutrient: Nutrient(name: "Lemak"), value: 8, uom: "g"),
                NutrientDetail(nutrient: Nutrient(name: "Karbo"), value: 10, uom: "g")
            ]
        ),
        Recipe(
            name: "Banana Pancakes",
            ripeness: [.ripeFirstPhase],
            details: "Step 1|Step 2|Step 3",
            ingredients: "Alpukat|Tomat|Bawang|Jeruk Nipis",
            tools: "Mangkok|Garpu",
            difficulty: 1,
            time: 30,
            portion: 2,
            fruit: sampleFruit,
            image: "HomescreenLogo",
            nutrients: [
                NutrientDetail(nutrient: Nutrient(name: "Kalori"), value: 120, uom: "kal"),
                NutrientDetail(nutrient: Nutrient(name: "Protein"), value: 4, uom: "g"),
                NutrientDetail(nutrient: Nutrient(name: "Lemak"), value: 8, uom: "g"),
                NutrientDetail(nutrient: Nutrient(name: "Karbo"), value: 10, uom: "g")
            ]
        ),
        Recipe(
            name: "Nasi Goreng Avocado",
            ripeness: [.ripeFirstPhase],
            details: "Step 1|Step 2|Step 3",
            ingredients: "Alpukat|Tomat|Bawang|Jeruk Nipis",
            tools: "Mangkok|Garpu",
            difficulty: 1,
            time: 30,
            portion: 2,
            fruit: sampleFruit,
            image: "HomescreenLogo",
            nutrients: [
                NutrientDetail(nutrient: Nutrient(name: "Kalori"), value: 120, uom: "kal"),
                NutrientDetail(nutrient: Nutrient(name: "Protein"), value: 4, uom: "g"),
                NutrientDetail(nutrient: Nutrient(name: "Lemak"), value: 8, uom: "g"),
                NutrientDetail(nutrient: Nutrient(name: "Karbo"), value: 10, uom: "g")
            ]
        )
    ]
    
    ResultView(
        ripenessTarget: .ripeFirstPhase,
        recipes: sampleRecipeList
    )
}
