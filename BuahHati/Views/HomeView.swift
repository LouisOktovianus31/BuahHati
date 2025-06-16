//
//  HomeView.swift
//  BuahHati
//
//  Created by Jose Andreas Lie on 12/06/25.
//

import Foundation
import SwiftUI

public struct HomeView: View {
    public var body: some View {
        
        ZStack {
            // Background Image
            Image("Background Image")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
                .ignoresSafeArea()

            // Content Overlay
            VStack(spacing: 20) {
                // Text Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Halo, ma!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)

                    Text("Siap cek alpukatmu?")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity, alignment: .topLeading)

                ZStack {
                    Image("Button Avocado")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 600)

                    // Button Section - Large and Clipped
                    Button(action: {
                        // NAVIGATE TO OTHER VIEW
                        print("Kepencet")
                    }) {
                        Color(.clear)
                            .frame(width: 250, height: 250)
                    }
                    .border(Color.white, width: 4)
                    .padding(.top, 100)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
