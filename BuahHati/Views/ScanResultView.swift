//
//  ScanResultView.swift
//  BuahHati
//
//  Created by Evan Lokajaya on 17/06/25.
//

import SwiftUI

struct ScanResultView: View {
    @Environment(\.modelContext) var modelContext
    
    @StateObject var viewModel: ScanResultViewModel

    @State private var isShowingRecipeList = false

    var body: some View {
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
                            Button(action: {
                                print("Go To How 2 Store")
                            }, label: {
                                Text("store my avocado")
                                    .underline()
                                    .foregroundColor(Color("BrownColor"))
                            })
                        }

                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Recipe(s)")
                                    .font(.title3)
                                    .bold()

                                Spacer()

                                Button(action: {
                                    isShowingRecipeList = true
                                }) {
                                    Text("See More")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .underline()
                                }
                                .background(
                                    NavigationLink(
                                        destination: RecipeListView(),
                                        isActive: $isShowingRecipeList
                                    ) {
                                        EmptyView()
                                    }
                                    .hidden()
                                )
                            }
                            .padding(.horizontal)

                            Text("based on your avocado's ripeness")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.horizontal)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(viewModel.filteredRecipes) { recipe in
                                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                            ScanResultRecipeComponent(recipe: recipe)
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
            }
            .onAppear {
                viewModel.setupModelContext(modelContext)
        }
    }
}
#Preview {
    ScanResultView(viewModel: ScanResultViewModel(ripeness: .ripeFirstPhase))
}
