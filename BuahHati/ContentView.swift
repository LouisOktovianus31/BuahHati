//
//  ContentView.swift
//  BuahHati
//
//  Created by Louis Oktovianus on 09/06/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            RecipeListView()
                .tabItem {
                    Label("Recipes", systemImage: "book")
                }
            
            StorageInstructionView()
                .tabItem {
                    Label("How 2 Store", systemImage: "archivebox")
                }
        }
    }
}

#Preview {
    ContentView()
}
