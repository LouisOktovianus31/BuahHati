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
            SplashScreenView()
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
        
        let calories = Nutrient(name: "Calories")
        let protein = Nutrient(name: "Protein")
        let fat = Nutrient(name: "Fat")
        let carbs = Nutrient(name: "Carbs")
        
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
                details: "Mix breadcrumbs, coriander, cumin, and salt in a bowl|Prepare beaten eggs in another bowl|Prepare flour in another bowl|Cut avocado lengthwise|Dip each avocado slice in flour, then egg, then breadcrumb mixture|Cook avocado in air fryer for 15 minutes at 200°C|Serve avocado fries with your choice of sauce, best eaten while warm",
                ingredients: "200g Breadcrumbs|1 tsp Coriander|1 tsp Cumin|100g All-Purpose Flour|2 Eggs|2 Avocados",
                tools: "Bowl|Air Fryer",
                difficulty: 3,
                time: 30,
                portion: 4,
                fruit: avocado,
                image: "AvocadoFries",
                nutrients: [
                    NutrientDetail(nutrient: calories, value: 490, uom: "cal"),
                    NutrientDetail(nutrient: protein, value: 14, uom: "g"),
                    NutrientDetail(nutrient: fat, value: 24, uom: "g"),
                    NutrientDetail(nutrient: carbs, value: 58, uom: "g")
                ]
            ),
            Recipe(
                name: "Avocado Pickles",
                ripeness: [.unripe, .breaking],
                details: "Mix vinegar, water, sugar, and salt in a saucepan|Bring to boil while stirring until sugar and salt dissolve|Remove vinegar solution and let cool to room temperature|Cut avocado lengthwise|Put garlic, sliced chili, avocado, and acidic solution mixture into a sealed container|Make sure avocado is submerged in the acidic solution|Let sit in refrigerator for at least 2 hours before consuming|Avocado Pickle can last up to one week in the refrigerator",
                ingredients: "240ml White Vinegar|240ml Water|50g Sugar|Sliced Garlic|Sliced Chili|2 Avocados",
                tools: "Saucepan|Sealed Container",
                difficulty: 1,
                time: 15,
                portion: 4,
                fruit: avocado,
                image: "AvocadoPickle",
                nutrients: [
                    NutrientDetail(nutrient: calories, value: 115, uom: "cal"),
                    NutrientDetail(nutrient: protein, value: 1, uom: "g"),
                    NutrientDetail(nutrient: fat, value: 15, uom: "g"),
                    NutrientDetail(nutrient: carbs, value: 11, uom: "g")
                ]
            ),
            Recipe(
                name: "Avocado Chicken Stir-Fry",
                ripeness: [.unripe, .breaking],
                details: "Mix chicken broth, soy sauce, cornstarch, and minced garlic in a bowl until all ingredients are well combined|Heat oil in wok over medium-high heat|Stir-fry chicken until half cooked or for five minutes|Transfer chicken to a plate|Add snow peas to wok and stir-fry until nearly wilted|Add mushrooms and green onions, cook until mushrooms are tender|Return chicken to wok and reduce heat to low-medium|Stir broth mixture and pour into wok|Add avocado and cook until sauce thickens, about 3 minutes|Avocado Chicken Stir-Fry is ready to serve",
                ingredients: "120ml Chicken Broth|60ml Soy Sauce|1 Garlic Clove|Sliced Chili|Green Onions|2 Avocados",
                tools: "Wok|Bowl",
                difficulty: 3,
                time: 45,
                portion: 5,
                fruit: avocado,
                image: "AvocadoStirFry",
                nutrients: [
                    NutrientDetail(nutrient: calories, value: 508, uom: "cal"),
                    NutrientDetail(nutrient: protein, value: 54, uom: "g"),
                    NutrientDetail(nutrient: fat, value: 24, uom: "g"),
                    NutrientDetail(nutrient: carbs, value: 40, uom: "g")
                ]
            ),
            Recipe(
                name: "Avocado Toast",
                ripeness: [.ripeFirstPhase, .ripeSecondPhase, .overripe],
                details: "Open avocado and remove the pit|Toast bread until golden brown|Slice avocado lengthwise|Place avocado slices on top of bread|Sprinkle sea salt and squeeze lemon over avocado|Mash avocado with fork on top of bread|Avocado Toast is ready to enjoy",
                ingredients: "1 Avocado|2 Slices of Bread|Lemon|Salt",
                tools: "Pan/Toaster|Fork|Knife",
                difficulty: 1,
                time: 10,
                portion: 2,
                fruit: avocado,
                image: "AvocadoToast",
                nutrients: [
                    NutrientDetail(nutrient: calories, value: 240, uom: "cal"),
                    NutrientDetail(nutrient: protein, value: 5, uom: "g"),
                    NutrientDetail(nutrient: fat, value: 16, uom: "g"),
                    NutrientDetail(nutrient: carbs, value: 23, uom: "g")
                ]
            ),
            Recipe(
                name: "Avocado Smoothie",
                ripeness: [.ripeFirstPhase, .ripeSecondPhase, .overripe],
                details: "Put all ingredients into blender|Blend all ingredients until well mixed|Pour smoothie into glass|Avocado Smoothie is ready to serve",
                ingredients: "1 Avocado|120g Frozen Banana|45ml Lime Juice|Sea Salt|120g Frozen Pineapple (Optional)|60g Spinach (Optional)",
                tools: "Blender",
                difficulty: 1,
                time: 5,
                portion: 1,
                fruit: avocado,
                image: "AvocadoSmoothies",
                nutrients: [
                    NutrientDetail(nutrient: calories, value: 404, uom: "cal"),
                    NutrientDetail(nutrient: protein, value: 6, uom: "g"),
                    NutrientDetail(nutrient: fat, value: 30, uom: "g"),
                    NutrientDetail(nutrient: carbs, value: 37, uom: "g")
                ]
            ),
            Recipe(
                name: "Avocado Brownies",
                ripeness: [.overripe],
                details: "Preheat oven to 163°C and spray 20x20cm baking pan with cooking spray|Mix mashed avocado, peanut butter, cocoa powder, honey, vanilla, and salt in a bowl|Stir until smooth without lumps|Add chocolate chips and stir gently so they don't break|Pour batter into pan and smooth with wooden spoon|Sprinkle a few chocolate chips on top if there are leftovers|Bake for 40 minutes|Cool completely before cutting and serving",
                ingredients: "240g Avocado|125g Peanut Butter|60g Cocoa Powder|85g Honey|5ml Vanilla|2g Sea Salt|90g Dark Chocolate Chips",
                tools: "Oven|Medium Bowl|Wooden Spoon|Spatula|20x20cm Baking Pan|Fork",
                difficulty: 3,
                time: 50,
                portion: 9,
                fruit: avocado,
                image: "AvocadoBrownies",
                nutrients: [
                    NutrientDetail(nutrient: calories, value: 126, uom: "cal"),
                    NutrientDetail(nutrient: protein, value: 4, uom: "g"),
                    NutrientDetail(nutrient: fat, value: 9, uom: "g"),
                    NutrientDetail(nutrient: carbs, value: 13, uom: "g")
                ]
            ),
            Recipe(
                name: "Avocado Muffins",
                ripeness: [.overripe],
                details: "Preheat oven to 163°C and grease muffin tin with a little butter|Mash avocado flesh until smooth or to your preference|In large bowl, beat butter and sugar until well combined|Add egg, vanilla, mashed avocado, and lime juice, mix well|In separate bowl, combine flour, baking powder, baking soda, cinnamon, and salt with fork|Fold dry ingredients into wet ingredients until just combined, don't overmix|Spoon batter into muffin tin, fill about 3/4 full|Sprinkle muffin tops with sugar before baking|Bake 18-20 minutes or until toothpick comes out clean|Cool at least 5 minutes before removing from tin",
                ingredients: "70g Butter|100g Sugar|1 Large Egg|5ml Vanilla|120g Avocado|10ml Lime Juice|125g All-Purpose Flour|2.5g Baking Powder|2.5g Baking Soda|2.5g Cinnamon Powder|1.5g Salt|12g Sugar",
                tools: "Oven|Muffin Tin|Small Bowl|Large Bowl|Medium Bowl|Fork|Mixer or Wooden Spoon|Toothpick",
                difficulty: 3,
                time: 40,
                portion: 5,
                fruit: avocado,
                image: "AvocadoMuffin",
                nutrients: [
                    NutrientDetail(nutrient: calories, value: 140, uom: "cal"),
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
