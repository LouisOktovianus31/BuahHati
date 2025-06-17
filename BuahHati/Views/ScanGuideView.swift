//
//  ScanGuideView.swift
//  BuahHati
//
//  Created by Evan Lokajaya on 16/06/25.
//

import SwiftUI

struct ScanGuideView: View {
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        ZStack {
            // Background Image
            Image("Background Image")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
                .ignoresSafeArea()
            
            VStack {
                Text("Hold up...")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 25)
                Text("Dont forget to...")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 25)
                
                GuideCardComponent()
                    .ignoresSafeArea()
                
                HStack {
                    Text("🔍")
                    Text("Ripeness prediction is based on avocado’s color")
                        .font(.caption)
                }
                .padding(.vertical, 5)
                .frame(maxWidth: .infinity)
                .background(
                    Capsule()
                        .fill(Color.gray.opacity(0.2))
                )
                .padding(.top, 15)
                .padding(.horizontal, 25)
                
                Button {
                    navigationPath.append("Camera")
                } label: {
                    Text("Continue")
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
                .padding(.vertical, 20)
                
            }
        }
        .navigationBarHidden(true)
        .navigationDestination(for: String.self) { destination in
            if destination == "Camera" {
                ScanView()
            }
        }
    }
}

#Preview {
    @Previewable @State var path = NavigationPath()
    ScanGuideView(navigationPath: $path)
}
