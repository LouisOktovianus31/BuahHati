import SwiftUI

struct NutritionRow: View {
    let items: [(value: String, label: String)]

    var body: some View {
        HStack(spacing: 24) {
            ForEach(0..<items.count, id: \.self) { index in
                if index != 0 {
                    Divider()
                        .frame(height: 40)
                }

                VStack(spacing: 4) {
                    Text(items[index].value)
                        .font(.headline)
                        .foregroundColor(Color("PrimaryColor"))
                    Text(items[index].label)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

#Preview {
    NutritionRow(items: [
        ("400", "kalori"),
        ("150g", "protein"),
        ("100g", "lemak"),
        ("120g", "karbo")
    ])
    .padding()
    .background(Color.clear) // transparan
}
