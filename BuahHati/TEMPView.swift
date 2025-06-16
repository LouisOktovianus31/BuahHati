import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Spacer()
                
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 400, height: 400)
                
                // Title
                Text("“PoC Buah Hati”")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                // Scan Button
                NavigationLink(destination: ScanView()) {
                    HStack {
                        Text("Scan Here")
                            .fontWeight(.medium)
                        Image(systemName: "camera") // Camera icon
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
                }
                
                Spacer()
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .navigationTitle("") // Optional: Set empty title to avoid clutter
            .navigationBarHidden(true) // Hide navigation bar for cleaner look
        }
    }
}

#Preview {
    MenuView()
}
