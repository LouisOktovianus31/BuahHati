//
//  GuideCardComponent.swift
//  BuahHati
//
//  Created by Evan Lokajaya on 16/06/25.
//

import SwiftUI

struct GuideCardComponent: View {
    var screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color("PrimaryColor"))
                .frame(width: screenWidth * 0.85, height: 128)
                .background(Color("PrimaryColor"))
                .cornerRadius(16)
            
            HStack(spacing: 10) {
                Image("AvocadoRipe")
                    .resizable()
                    .frame(width: 80, height: 100)
                    
                Text("Scan only one avocado at a time")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                Spacer()
                Image("NumberOne")
                    .resizable()
                    .frame(maxWidth: 50, maxHeight: 80)
                
                Spacer()
            }
            .frame(width: screenWidth * 0.82, height: 128)
            .background(Color.white)
            .cornerRadius(16)
        }
        .padding(.bottom, 25)
        
        ZStack(alignment: .trailing) {
            Rectangle()
                .fill(Color("PrimaryColor"))
                .frame(width: screenWidth * 0.85, height: 128)
                .background(Color("PrimaryColor"))
                .cornerRadius(16)
            
            HStack(spacing: 10) {
                Spacer()
                Image("NumberTwo")
                    .resizable()
                    .frame(maxWidth: 50, maxHeight: 75)
                
                    
                Text("The lighting should be bright and clear ")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.trailing)
                Image("Lightbulb")
                    .resizable()
                    .frame(width: 75, height: 100)
                
                Spacer()
            }
            .frame(width: screenWidth * 0.82, height: 128)
            .background(Color.white)
            .cornerRadius(16)
        }
        .padding(.bottom, 25)
        
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color("PrimaryColor"))
                .frame(width: screenWidth * 0.85, height: 128)
                .background(Color("PrimaryColor"))
                .cornerRadius(16)
            
            HStack(spacing: 16) {
                Image("Camera")
                    .resizable()
                    .frame(width: 100, height: 100)
                    
                Text("Take a steady and clear photo")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                Spacer()
                Image("NumberThree")
                    .resizable()
                    .frame(maxWidth: 50, maxHeight: 80)
                
                Spacer()
            }
            .frame(width: screenWidth * 0.82, height: 128)
            .background(Color.white)
            .cornerRadius(16)
        }
        
        
        
    }
}

#Preview {
    GuideCardComponent()
}
