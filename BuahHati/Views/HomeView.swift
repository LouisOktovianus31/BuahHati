//
//  HomeView.swift
//  BuahHati
//
//  Created by Jose Andreas Lie on 12/06/25.
//

import Foundation
import SwiftUI

enum HomeViewDestination {
    case scanGuide
}

public struct HomeView: View {
    @State private var navigationPath = NavigationPath()
    
    public var body: some View {
        NavigationStack(path: $navigationPath){
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
                        Text("Hi, mom!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text("Ready to check your avocado?")
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
                        
                        // Button Section - Large and Clipped
                        Button(action: {
                            // NAVIGATE TO OTHER VIEW
                            print("Kepencet")
                            navigationPath.append(HomeViewDestination.scanGuide)
                            
                        }) {
                            Circle()
                                .fill(Color.clear)
                                .frame(width: 250, height: 250)
                                .cornerRadius(0)
                        }
                        .offset(y: 50)
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(for: HomeViewDestination.self) { destination in
                if destination == .scanGuide {
                    ScanGuideView(navigationPath: $navigationPath)
                }
            }
        }
        
    }
}

#Preview {
    HomeView()
}
