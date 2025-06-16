import SwiftUI

struct RecipeHeader: View {
    let title: String
    let time: String
    let portion: String

    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            HStack(spacing: 20) {
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .foregroundColor(Color("PrimaryColor"))
                    Text(time)
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }

                HStack(spacing: 4) {
                    Image(systemName: "fork.knife")
                        .foregroundColor(Color("PrimaryColor"))
                    Text(portion)
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(24)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)
    }
}

#Preview {
    RecipeHeader(title: "Avocado Cake", time: "45 menit", portion: "5 porsi")
}
