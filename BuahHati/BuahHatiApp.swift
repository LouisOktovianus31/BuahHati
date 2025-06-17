//
//  BuahHatiApp.swift
//  BuahHati
//
//  Created by Louis Oktovianus on 09/06/25.
//

import SwiftUI
import SwiftData

@main
struct BuahHatiApp: App {
    
    let modelContainer: ModelContainer = {
        let schema = Schema([Fruit.self, Nutrient.self, NutrientDetail.self, Recipe.self, StorageInstruction.self])
        
        let modelConfiguration = ModelConfiguration(schema: schema)

        do {
            return try ModelContainer(for: schema)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
                .onAppear(perform: seedDataIfNeeded)
//            ScanView()
        }
        .modelContainer(modelContainer)
    }
    
    private func seedDataIfNeeded() {
        let context = modelContainer.mainContext
        
        // Check if data already exists
        let fetchRequest = FetchDescriptor<Recipe>()
        do {
            let existingRecipes = try context.fetch(fetchRequest)
            if !existingRecipes.isEmpty {
                return // Data already exists
            }
        } catch {
            print("Error checking existing data: \(error)")
        }
        
        // Create base entities
        let avocado = Fruit(name: "Avocado")
        
        let calories = Nutrient(name: "Kalori")
        let protein = Nutrient(name: "Protein")
        let fat = Nutrient(name: "Lemak")
        let carbs = Nutrient(name: "Karbohidrat")
        
        // Insert base entities
        context.insert(avocado)
        context.insert(calories)
        context.insert(protein)
        context.insert(fat)
        context.insert(carbs)
        
        // Create recipes with your data
        let recipes = [
            Recipe(
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
            ),
            Recipe(
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
            ),
            Recipe(
                name: "Avocado Chicken Stir-Fry",
                ripeness: [.unripe, .breaking],
                details: "Campurkan kaldu ayam, kecap asin, tepung maizena, dan bawang putih cincang dalam mangkuk hingga semua bahan tercampur rata|Panaskan minyak dalam wok dengan api sedang-tinggi|Tumis ayam hingga setengah matang atau selama lima menit|Pindahkan ayam ke piring|Masukkan kapri ke dalam wok dan tumis hingga mendekati layu|Tambahkan jamur dan daun bawang, masak hingga jamur empuk|Masukkan kembali ayam ke dalam wok dan turunkan api menjadi api kecil-sedang|Aduk larutan kaldu dan tuang ke dalam wok|Masukkan alpukat dan masak hingga saus mengental sekitar 3 menit|Avocado Chicken Stir-Fry siap untuk disajikan",
                ingredients: "120ml Kaldu Ayam|60ml Kecap Asin|1 Bawang Putih|Cabai Iris|Daun Bawang| 2 Buah Alpukat",
                tools: "Wok|Mangkuk",
                difficulty: 3,
                time: 45,
                portion: 5,
                fruit: avocado,
                image: "AvocadoStirFry",
                nutrients: [
                    NutrientDetail(nutrient: calories, value: 508, uom: "kal"),
                    NutrientDetail(nutrient: protein, value: 54, uom: "g"),
                    NutrientDetail(nutrient: fat, value: 24, uom: "g"),
                    NutrientDetail(nutrient: carbs, value: 40, uom: "g")
                ]
            ),
            Recipe(
                name: "Avocado Toast",
                ripeness: [.ripeFirstPhase, .ripeSecondPhase, .overripe],
                details: "Buka alpukat dan buang bijinya|Panggang roti hingga kecoklatan|Iris alpukat secara memanjang|Taruh potongan alpukat diatas roti|Taburkan garam laut dan beri perasan lemon pada alpukat|Hancurkan alpukat dengan menggunakan garpu diatas roti|Avocado Toast siap untuk disantap",
                ingredients: "1 Buah Alpukat|2 Lembar Roti|Lemon|Garam Dapur",
                tools: "Pan/Toaster|Garpu|Pisau",
                difficulty: 1,
                time: 10,
                portion: 2,
                fruit: avocado,
                image: "AvocadoToast",
                nutrients: [
                    NutrientDetail(nutrient: calories, value: 240, uom: "kal"),
                    NutrientDetail(nutrient: protein, value: 5, uom: "g"),
                    NutrientDetail(nutrient: fat, value: 16, uom: "g"),
                    NutrientDetail(nutrient: carbs, value: 23, uom: "g")
                ]
            ),
            Recipe(
                name: "Avocado Smoothies",
                ripeness: [.ripeFirstPhase, .ripeSecondPhase, .overripe],
                details: "Masukkan semua bahan ke dalam blender|Blend semua bahan hingga tercampur rata|Tuangkan smoothies ke dalam gelas|Avocado Smoothies siap untuk disajikan",
                ingredients: "1 Buah Alpukat|120g Pisang Beku|45ml Air Jeruk Nipis|Garam Laut|120g Nanas Beku (Optional)|60g Bayam (Opsional)",
                tools: "Blender",
                difficulty: 1,
                time: 5,
                portion: 1,
                fruit: avocado,
                image: "AvocadoSmoothies",
                nutrients: [
                    NutrientDetail(nutrient: calories, value: 404, uom: "kal"),
                    NutrientDetail(nutrient: protein, value: 6, uom: "g"),
                    NutrientDetail(nutrient: fat, value: 30, uom: "g"),
                    NutrientDetail(nutrient: carbs, value: 37, uom: "g")
                ]
            ),
            Recipe(
                name: "Avocado Brownies",
                ripeness: [.overripe],
                details: "Panaskan oven ke suhu 163°C dan semprot loyang 20x20cm dengan cooking spray|Campurkan alpukat tumbuk, selai kacang, bubuk kakao, madu, vanilla, dan garam ke dalam mangkuk|Aduk hingga rata tanpa gumpalan|Masukkan chocolate chips dan aduk perlahan agar tidak hancur|Tuang adonan ke loyang dan ratakan dengan sendok kayu|Taburi sedikit chocolate chips di atas jika ada sisa|Panggang selama 40 menit|Dinginkan sepenuhnya sebelum dipotong dan disajikan",
                ingredients: "240g Alpukat|125g Selai Kacang|60g Bubuk Kakao|85g Madu|5ml Vanilla|2g Garam Laut|90g Dark Chocolate Chips",
                tools: "Oven|Mangkuk Sedang|Sendok Kayu|Spatula|Loyang 20x20cm|Garpu",
                difficulty: 3,
                time: 50,
                portion: 9,
                fruit: avocado,
                image: "AvocadoBrownies",
                nutrients: [
                    NutrientDetail(nutrient: calories, value: 126, uom: "kal"),
                    NutrientDetail(nutrient: protein, value: 4, uom: "g"),
                    NutrientDetail(nutrient: fat, value: 9, uom: "g"),
                    NutrientDetail(nutrient: carbs, value: 13, uom: "g")
                ]
            ),
            Recipe(
                name: "Avocado Muffins",
                ripeness: [.overripe],
                details: "Panaskan oven 163°C dan olesi loyang muffin dengan sedikit mentega|Tumbuk daging alpukat hingga halus atau sesuai preferensi|Dalam mangkuk besar, kocok mentega dan gula pasir hingga tercampur rata|Tambahkan telur, vanilla, alpukat tumbuk, dan air jeruk nipis, aduk rata|Dalam mangkuk terpisah, campur tepung, baking powder, baking soda, kayu manis, dan garam dengan garpu|Campur (Fold) bahan kering ke dalam bahan basah hingga tercampur, jangan overmix|Sendokkan adonan ke loyang muffin, isi sekitar 3/4 penuh|Taburi permukaan muffin dengan gula sebelum dipanggang|Panggang 18-20 menit atau hingga tusuk gigi keluar bersih|Dinginkan minimal 5 menit sebelum dikeluarkan dari loyang",
                ingredients: "70g Mentega|100g Gula Pasir|1 Telur Besar|5ml Vanilla|120g Alpukat|10ml Air Jeruk Nipis|125g Tepung Terigu|2.5g Baking Powder|2.5g Baking Soda|2.5g Bubuk Kayu Manis|1.5g Garam|12g Gula",
                tools: "Oven|Loyang Muffin|Mangkuk Kecil|Mangkuk Besar|Mangkuk Sedang|Garpu|Mixer atau Sendok Kayu|Tusuk Gigi",
                difficulty: 3,
                time: 40,
                portion: 5,
                fruit: avocado,
                image: "AvocadoMuffin",
                nutrients: [
                    NutrientDetail(nutrient: calories, value: 140, uom: "kal"),
                    NutrientDetail(nutrient: protein, value: 2, uom: "g"),
                    NutrientDetail(nutrient: fat, value: 7, uom: "g"),
                    NutrientDetail(nutrient: carbs, value: 19, uom: "g")
                ]
            )
        ]
        
        // Insert all recipes
        for recipe in recipes {
            context.insert(recipe)
        }
        
        // Save the context
        do {
            try context.save()
            print("Seed data successfully inserted")
        } catch {
            print("Error saving seed data: \(error)")

        }
    }
}

// MARK: - Loader untuk ambil data dari SwiftData dan tampilkan ResultView
struct ContentViewLoader: View {
    @Query var recipes: [Recipe]

    var body: some View {
        // Ubah target kematangan di sini kalau mau (misal .overripe, .breaking, dll)
        ResultView(ripenessTarget: .ripeFirstPhase, recipes: recipes)
    }
}
