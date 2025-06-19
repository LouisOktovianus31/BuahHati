//
//  ScanResultView.swift
//  BuahHati
//
//  Created by Evan Lokajaya on 17/06/25.
//

import SwiftUI

enum ScanResultViewDestination: Hashable {
    case recipeList
    case howToStore
    case recipeDetail(Recipe)
}

struct ScanResultView: View {
    @Environment(\.modelContext) var modelContext
    
    @StateObject var viewModel: ScanResultViewModel

    @State private var isShowingRecipeList = false
    
    @Binding var navigationPath: NavigationPath

    var body: some View {
            ZStack(alignment: .bottom) {
                Color("BackgroundColor")
                    .ignoresSafeArea(.all, edges: .top)

                VStack(spacing: 0) {
                    // MARK: Hijau Atas dengan Wave
                    ZStack {
                        WaveShape()
                            .fill(Color("PrimaryColor"))
                            .frame(height: 350)
                            .ignoresSafeArea(.all, edges: .top)
                            .padding(.top, -70)
                        
                        VStack(spacing: 12) {
                            Image(viewModel.getImageName())
                                .resizable()
                                .scaledToFit()
                                .frame(width: 110, height: 110)
                            
                            Text(viewModel.ripeness.rawValue)
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)
                            
                            Text(viewModel.getRipenessDescription())
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.bottom, 40)
                    
                    Spacer()
                    
                    // MARK: Section Putih
                    VStack(spacing: 20) {
                        Text(viewModel.getRipenessCaption())
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        HStack {
                            Text("How to")
                            Button {
                                navigationPath.append(ScanResultViewDestination.howToStore)
                            } label: {
                                Text("store my avocado")
                                    .underline()
                                    .foregroundColor(Color("BrownColor"))
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Recipe(s)")
                                    .font(.title3)
                                    .bold()
                                
                                Spacer()
                                
                                Button(action: {
                                    navigationPath.append(ScanResultViewDestination.recipeList)
                                }) {
                                    Text("See More")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .underline()
                                }
                            }
                            .padding(.horizontal)
                            
                            Text("based on your avocado's ripeness")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(viewModel.filteredRecipes) { recipe in
                                        ScanResultRecipeComponent(recipe: recipe)
                                            .onTapGesture {
                                                navigationPath.append(ScanResultViewDestination.recipeDetail(recipe))
                                            }
                                    }
                                }
                                .padding(.leading, 16)
                                .padding(.trailing, 40)
                            }
                        }
                        
                        Spacer()
                        
                        Button {
                            navigationPath = NavigationPath()
                        } label: {
                            Text("Back to Homepage")
                                .padding()
                                .font(.title2)
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(.white)
                                .background(
                                    Capsule()
                                        .fill(Color("PrimaryColor"))
                                )
                        }
                        .padding(.horizontal, 25)
                        
//                        Spacer()
//                            .padding(.bottom, 110)
                        
                    }
                    .padding(.top, -40)
                    .background(
                        Color("BackgroundColor")
                            .clipShape(RoundedCorner(radius: 40, corners: [.topLeft, .topRight]))
                    )
                    
                    
                }
                
            }
            .navigationDestination(for: ScanResultViewDestination.self) { destination in
                if (destination == .recipeList) {
                }
                switch destination {
                    case .recipeList:
                        RecipeListView()
                    case .howToStore:
                    StorageInstructionView(selectedTab: viewModel.ripeness)
                    case .recipeDetail(let recipe): // ✅ Fixed syntax
                        RecipeDetailView(recipe: recipe)
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                viewModel.setupModelContext(modelContext)
            }
        }
    }

#Preview {
    @Previewable @State var navigationPath = NavigationPath()
    ScanResultView(viewModel: ScanResultViewModel(ripeness: .ripeFirstPhase), navigationPath: $navigationPath)
}
