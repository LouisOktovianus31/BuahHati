//
//  FavoriteRecipeComponent.swift
//  BuahHati
//
//  Created by Evan Lokajaya on 13/06/25.
//

import SwiftUI

struct FavoriteRecipeComponent: View {
    var isFavorite: Bool
    
    var body: some View {
        if isFavorite {
            ZStack {
                Image(systemName: "circle.fill")
                    .foregroundStyle(Color("PrimaryColor"))
                    .scaleEffect(2)
                Image(systemName: "heart.fill")
                    .foregroundStyle(.red)
                    .scaleEffect(1)
            }
        }
        else {
            ZStack {
                Image(systemName: "circle.fill")
                    .foregroundStyle(Color("PrimaryColor"))
                    .scaleEffect(2)
                Image(systemName: "heart.fill")
                    .foregroundStyle(.white)
                    .scaleEffect(1)
            }
        }
    }
}

#Preview {
    FavoriteRecipeComponent(isFavorite: true).padding(20)
    FavoriteRecipeComponent(isFavorite: false).padding(20)
}
