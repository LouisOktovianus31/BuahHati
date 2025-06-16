import SwiftUI

struct StepItem {
    let title: String
    let description: String
}

struct StepSection: View {
    let steps: [StepItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 24) {
                Text("Langkah-langkah")
                    .font(.title3)
                    .bold()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        ForEach(0..<steps.count, id: \.self) { index in
                            HStack(alignment: .top, spacing: 12) {
                                VStack {
                                    Circle()
                                        .strokeBorder(Color("PrimaryColor"), lineWidth: 2)
                                        .frame(width: 16, height: 16)

                                    if index < steps.count - 1 {
                                        Rectangle()
                                            .fill(Color("PrimaryColor"))
                                            .frame(width: 2, height: 60)
                                            .padding(.top, -2)
                                    }
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Step \(index + 1)")
                                        .font(.headline)
                                        .foregroundColor(Color("PrimaryColor"))

                                    Text(steps[index].description)
                                        .foregroundColor(.gray)
                                }
                            }
                        }

                        VStack(alignment: .center, spacing: 12) {
                            Text("🎉 Selamat kamu sudah menyelesaikan resep ini!")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.primary)

                            Text("Selamat menikmati alpukatmu bersama Sang Buah Hati")
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)

                            Image("Avocado")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 12)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(24)
            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 3)
        }
        .padding(.horizontal) // jangan pakai padding semua sisi
    }
}

#Preview {
    StepSection(steps: [
        StepItem(title: "Step 1", description: "Langkah awal, siapkan bahan-bahan."),
        StepItem(title: "Step 2", description: "Campurkan bahan kering."),
        StepItem(title: "Step 3", description: "Tambahkan bahan cair."),
        StepItem(title: "Step 4", description: "Aduk hingga rata."),
        StepItem(title: "Step 5", description: "Diamkan adonan selama 10 menit."),
        StepItem(title: "Step 6", description: "Panaskan oven."),
        StepItem(title: "Step 7", description: "Tuang adonan ke dalam loyang."),
        StepItem(title: "Step 8", description: "Panggang selama 30 menit."),
        StepItem(title: "Step 9", description: "Keluarkan dari oven dan biarkan dingin."),
        StepItem(title: "Step 10", description: "Hidangkan kue dan nikmati.")
    ])
}
