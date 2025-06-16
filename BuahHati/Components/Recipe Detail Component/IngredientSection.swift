import SwiftUI

struct IngredientSection: View {
    let ingredients: [String]
    @State private var isExpanded = true

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(spacing: 0) {
                // HEADER
                HStack {
                    Text("Bahan-bahan")
                        .font(.headline)
                        .bold()
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                        .foregroundColor(Color("PrimaryColor"))
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                isExpanded.toggle()
                            }
                        }
                }
                .padding()

                // BODY
                if isExpanded {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(ingredients, id: \.self) { item in
                            Label {
                                Text(item)
                                    .foregroundColor(.gray)
                                    .font(.body)
                            } icon: {
                                Text("•")
                                    .font(.system(size: 14))
                                    .offset(y: 2) // naik dikit biar sejajar teks
                            }
                            .labelStyle(LeadingLabelStyle())
                        }
                    }
                    .padding([.horizontal, .bottom])
                    .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
            .background(Color.white)
            .cornerRadius(24)
            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 3)
        }
        .animation(.easeInOut, value: isExpanded)
    }
}

// ✅ Custom LabelStyle: bullet & text tetap kiri
struct LeadingLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .top, spacing: 8) {
            configuration.icon
            configuration.title
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    IngredientSection(ingredients: [
        "1 alpukat matang",
        "220g butter",
        "200g gula",
        "4 butir telur",
        "350g tepung",
        "50ml susu"
    ])
}
