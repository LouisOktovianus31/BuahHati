import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            RecipesView()
                .tabItem {
                    Label("Recipes", systemImage: "book")
                }
            
            StorageInstructionView()
                .tabItem {
                    Label("How 2 Store", systemImage: "archivebox")
                }
        }
}

#Preview {
    ContentView()
}
