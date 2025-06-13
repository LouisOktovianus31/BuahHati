import SwiftUI

struct ResultView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Color("BackgroundColor").ignoresSafeArea()

            VStack(spacing: 0) {
                // MARK: Hijau Atas dengan Wave
                ZStack {
                    WaveShape()
                        .fill(Color("PrimaryColor"))
                        .frame(height: 360)
                        .ignoresSafeArea(edges: .top)

                    VStack(spacing: 16) {
                        HStack {
                            Button(action: {
                                // Handle back
                            }) {
                                Image(systemName: "arrow.left")
                                    .font(.title2)
                                    .foregroundColor(.black)
                                    .padding(.leading, 16)
                            }
                            Spacer()
                        }
                        .padding(.top, -20)

                        Image("Avocado")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 110, height: 110)

                        Text("Belum Matang")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()

                // MARK: Section Putih
                VStack(spacing: 20) {
                    Text("Estimasi sebelum matang: 3–4 hari")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)

                    Text("Wah, alpukat kamu belum siap nih. Tapi bisa ditunggu kok. Sambil nunggu, coba deh resep ini~ 🍽️")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .fixedSize(horizontal: false, vertical: true)

                    Button(action: {}) {
                        Text("Cara menyimpan alpukat saya")
                            .underline()
                            .foregroundColor(Color("BrownColor"))
                    }
                    
                    

                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Recipe")
                                .font(.title3)
                                .bold()
                            
                            Spacer()
                            
                            Button(action: {
                                // Aksi kalau mau navigasi
                            }) {
                                Text("See More")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .underline()
                            }
                        }
                        .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(0..<3) { _ in
                                    VStack(alignment: .leading, spacing: 8) {
                                        Image("HomescreenLogo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 130, height: 90)
                                            .clipped()
                                            .cornerRadius(12)

                                        Text("Guaga Mole")
                                            .font(.headline)

                                        HStack(spacing: 4) {
                                            Image(systemName: "clock")
                                            Text("30 menit")
                                                .font(.subheadline)
                                        }
                                        .foregroundColor(.gray)
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(16)
                                    .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
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


            HStack {
                Spacer()
                Image(systemName: "house.fill")
                    .font(.title2)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "doc.text")
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.5))
                Spacer()
                Image(systemName: "archivebox")
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.5))
                Spacer()
            }
            .padding(.bottom, 32)
            .padding(.vertical, 16)
            .background(Color("PrimaryColor"))
            .clipShape(RoundedCorner(radius: 0, corners: [.topLeft, .topRight]))
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: -2)
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    ResultView()
}
