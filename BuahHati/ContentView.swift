import SwiftUI

struct ContentView: View {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "PrimaryColor")

        let itemAppearance = appearance.stackedLayoutAppearance
        itemAppearance.normal.iconColor = UIColor.black
        itemAppearance.selected.iconColor = UIColor.white

        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black]
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]

        appearance.stackedLayoutAppearance = itemAppearance

   
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Scan", systemImage: "camera")
                }

            RecipeListView()
                .tabItem {
                    Label("Recipes", systemImage: "book")
                }

            StorageInstructionView()
                .tabItem {
                    Label("Store", systemImage: "archivebox")
                }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    ContentView()
}
