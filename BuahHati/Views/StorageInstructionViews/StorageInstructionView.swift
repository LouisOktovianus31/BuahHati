//
//  BuahHati
//  StorageInstructionView.swift
//
//  Created by Jose Andreas Lie on 12/06/25.
//

import SwiftUI

struct StorageInstructionView: View {
    @State private var selectedTab = 0
//    let screenWidth = UIScreen.main.bounds.width
//    let horizontalPadding: CGFloat = 16
//    let cardWidth = screenWidth - (horizontalPadding * 2)
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("How to Store")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding([.top, .leading], 24)
            

            // Segmented Control
            Picker("Tabs", selection: $selectedTab) {
                Text("Unripe").tag(0)
                Text("Ripe").tag(1)
                Text("Overripe").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 16)
            .tint(Color.primary)
//            .tint(Color(red: 0.34, green: 0.55, blue: 0.39))
            
            // Content based on selected tab
            Spacer()
            
            switch selectedTab {
            case 0:
                ScrollView{
                    // MARK : SEGMENT BELUM MATANG, MASIH HARD CODE BGT
                    VStack(alignment: .leading, ){
                        // ----- CARD TINGKAT MATANG ----- //
                        HStack(alignment: .center, spacing: 12) {
                            // Image
                            Image("StorageInstruction-Unripe")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 112)
                            
                            // Content
                            VStack(alignment: .leading, spacing: 12) {
                                // Title
                                Text("Unripe Avocado")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                // Characteristics
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("• Bright green skin")
                                        .font(.body)
                                        .foregroundColor(.primary)
                                    Text("• Feels firm when pressed")
                                        .font(.body)
                                        .foregroundColor(.primary)

                //                    ForEach(characteristics, id: \.self) { characteristic in
                //                        Text(characteristic)
                //                            .font(.body)
                //                            .foregroundColor(.black)
                //                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        }
                        .padding(16)
                        .background(Color(red: 0.83, green: 0.88, blue: 0.74))
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
                        // ------------------------------- //
                        
                        Text("Storage Instructions")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .padding([.top], 24)
                        
                        // ----- CARD Satu Lagi ----- //
                        ZStack{
                            
                            VStack(alignment: .center, spacing: 20) {
                                //Fridge
                                HStack(alignment: .center, spacing: 12){
                                    // Image
                                    Image("StorageInstruction-Fridge")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 80, height: 112)
                                    
                                    // Content
                                    VStack(alignment: .leading, spacing: 20) {
                                        // Title
                                        VStack(spacing: 8){
                                            Text("In the Fridge")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundColor(.primary)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            Text("Last up to 7 days")
                                                .font(.title3)
                                                .fontWeight(.medium)
                                                .foregroundColor(.primary)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }

                                        
                                        // Characteristics
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text("Want to slow down ripening? Pop it in the fridge!")
                                                .font(.body)
                                                .foregroundColor(.primary)
                        //                    ForEach(characteristics, id: \.self) { characteristic in
                        //                        Text(characteristic)
                        //                            .font(.body)
                        //                            .foregroundColor(.black)
                        //                    }
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                }
                                
                                Divider().padding(.vertical, 8)
                                
                                // Temperature
                                HStack(alignment: .center, spacing: 12){
                                    // Image
                                    Image("StorageInstruction-Temperature")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 80, height: 112)
                                    
                                    // Content
                                    VStack(alignment: .leading, spacing: 20) {
                                        // Title
                                        VStack(spacing: 8){
                                            Text("Room Temperature")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundColor(.primary)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            Text("Last 3-5 days")
                                                .font(.title3)
                                                .fontWeight(.medium)
                                                .foregroundColor(.primary)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }

                                        
                                        // Characteristics
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text("Eating it soon? Leave it out at room temperature!")
                                                .font(.body)
                                                .foregroundColor(.primary)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                }

                            }
                            .background(Image("BackgroundOverlay"))
                            .padding(16)
                            .cornerRadius(16)
                        }
                        .background(Color.white)
                        .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
                        // ------------------------------- //
                        
                    }.padding(16)
                }
            case 1:
                ScrollView{
                    // MARK : SEGMENT BELUM MATANG, MASIH HARD CODE BGT
                    VStack(alignment: .leading, ){
                        // ----- CARD TINGKAT MATANG ----- //
                        HStack(alignment: .center, spacing: 12) {
                            // Image
                            Image("StorageInstruction-Ripe")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 112)
                            
                            // Content
                            VStack(alignment: .leading, spacing: 12) {
                                // Title
                                Text("Ripe Avocado")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                // Characteristics
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("• Dark green skin")
                                        .font(.body)
                                        .foregroundColor(.primary)
                                    Text("• Soft to the touch")
                                        .font(.body)
                                        .foregroundColor(.primary)

                //                    ForEach(characteristics, id: \.self) { characteristic in
                //                        Text(characteristic)
                //                            .font(.body)
                //                            .foregroundColor(.black)
                //                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        }
                        .padding(16)
                        .background(Color(red: 0.76, green: 0.89, blue: 0.56))
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
                        // ------------------------------- //
                        
                        Text("Storage Instructions")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .padding([.top], 24)
                        
                        // ----- CARD Satu Lagi ----- //
                        ZStack{
                            
                            VStack(alignment: .center, spacing: 20) {
                                //Fridge
                                HStack(alignment: .center, spacing: 12){
                                    // Image
                                    Image("StorageInstruction-Fridge")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 80, height: 112)
                                    
                                    // Content
                                    VStack(alignment: .leading, spacing: 20) {
                                        // Title
                                        VStack(spacing: 8){
                                            Text("In the Fridge")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundColor(.primary)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            Text("Last 2-3 days")
                                                .font(.title3)
                                                .fontWeight(.medium)
                                                .foregroundColor(.primary)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }

                                        
                                        // Characteristics
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text("Keep it in the fridge to stay fresh!")
                                                .font(.body)
                                                .foregroundColor(.primary)
                        //                    ForEach(characteristics, id: \.self) { characteristic in
                        //                        Text(characteristic)
                        //                            .font(.body)
                        //                            .foregroundColor(.black)
                        //                    }
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                }
                                
                                Divider().padding(.vertical, 8)
                                
                                // Temperature
                                HStack(alignment: .center, spacing: 12){
                                    // Image
                                    Image("StorageInstruction-CutAvocado")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 80, height: 112)
                                    
                                    // Content
                                    VStack(alignment: .leading, spacing: 20) {
                                        // Title
                                        VStack(spacing: 8){
                                            Text("Cut Avocado")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundColor(.primary)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            Text("Last 1-2 days")
                                                .font(.title3)
                                                .fontWeight(.medium)
                                                .foregroundColor(.primary)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }

                                        
                                        // Characteristics
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text("Drizzle with lemon and put in an airtight container!")
                                                .font(.body)
                                                .foregroundColor(.primary)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                }

                            }
                            .background(Image("BackgroundOverlay"))
                            .padding(16)
                            .cornerRadius(16)
//                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                        }
                        .background(Color.white)
                        .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
                        // ------------------------------- //
                        
                    }.padding(16)
                }
            case 2:
                ScrollView {
                    // MARK : SEGMENT BELUM MATANG, MASIH HARD CODE BGT
                    VStack(alignment: .leading) {
                        // ----- CARD TINGKAT MATANG ----- //
                        HStack(alignment: .center, spacing: 12) {
                            // Image
                            Image("StorageInstruction-Overripe")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 112)
                            
                            // Content
                            VStack(alignment: .leading, spacing: 12) {
                                // Title
                                Text("Overripe Avocado")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                // Characteristics
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("• Brown spots on the skin")
                                        .font(.body)
                                        .foregroundColor(.primary)
                                    Text("• Very soft when pressed")
                                        .font(.body)
                                        .foregroundColor(.primary)

                            //                    ForEach(characteristics, id: \.self) { characteristic in
                            //                        Text(characteristic)
                            //                            .font(.body)
                            //                            .foregroundColor(.black)
                            //                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        }
                        .padding(16)
                        .background(Color(red: 0.89, green: 0.86, blue: 0.56))
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
                        // ------------------------------- //
                        
                        Text("Storage Instructions")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .padding([.top], 24)
                        
                        // ----- CARD Satu Lagi (SAME WIDTH AS ABOVE) ----- //
                        VStack(alignment: .center, spacing: 20) {
                            Image("WarningAvocado")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 162)
                            
                            Text("Careful")
                                .font(.title)
                                .fontWeight(.black)
                                .foregroundColor(.orange)
                            
                            Text("Your avocado is overripe. Use it quickly before it goes bad!")
                                .multilineTextAlignment(.center)
                                .font(.body)
                                .foregroundColor(.primary)
                                .frame(width: 244, height: 48)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(16)
                        .background(Image("BackgroundOverlay"))
                        .cornerRadius(16)
                        .background(Color.white)
                        .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
                        // ------------------------------- //
                        
                    }
                    .padding(16)
                }
                
            default:
                Text("404")
                Text("Page Not Found")
            }
            
            Spacer()
        }
        .background(Color(red: 0.98, green: 1, blue: 0.95))
        
    }
}

// Preview
//struct SimpleSegmentedView_Previews: PreviewProvider {
//    static var previews: some View {
//        SimpleSegmentedView()
//    }
//}



#Preview {
    StorageInstructionView()
}
