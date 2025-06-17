//
//  ResultsView.swift
//  BuahHati
//
//  Created by Hendrik Nicolas Carlo on 16/06/25.
//

import SwiftUI

struct ResultsView: View {
    var label: String
    
    var body: some View {
        ZStack{
            Image("Avocado")
                .resizable()
                .frame(width: 135, height: 175)
                .zIndex(2)
//                .background(.black)
                .offset(x: -125, y: -20)
                
            HStack(spacing: 15) {
                Color.clear
                    .frame(width: 120)
                VStack(alignment: .leading, spacing: -5) {
                    Text("Kemungkinan,")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.white)
                    Text(label)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    Text("Matang")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }
                Spacer()
                Image(systemName: "chevron.right.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
            }
            .padding()
            .frame(height: 140)
            .background(Color("PrimaryColor"))
            .cornerRadius(20)
        }
    }
}

#Preview {
    ResultsView(label: "Belum")
}
