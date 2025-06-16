import SwiftUI

enum Tab {
    case home, recipes, storage
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab

    var body: some View {
        HStack {
            Spacer()

            Button(action: {
                selectedTab = .home
            }) {
                Image(systemName: "house.fill")
                    .font(.system(size: 28))
                    .foregroundColor(selectedTab == .home ? .white : Color.gray.opacity(0.5))
            }

            Spacer()

            Button(action: {
                selectedTab = .recipes
            }) {
                Image(systemName: "book.fill")
                    .font(.system(size: 28))
                    .foregroundColor(selectedTab == .recipes ? .white : Color.gray.opacity(0.5))
            }

            Spacer()

            Button(action: {
                selectedTab = .storage
            }) {
                Image(systemName: "archivebox.fill")
                    .font(.system(size: 28))
                    .foregroundColor(selectedTab == .storage ? .white : Color.gray.opacity(0.5))
            }

            Spacer()
        }
        .padding(.vertical, 20)
        .background(Color("PrimaryColor"))
        .clipShape(RoundedRectangle(cornerRadius: 0))
    }
}

#Preview {
    PreviewWrapper()
}

struct PreviewWrapper: View {
    @State private var selectedTab: Tab = .home

    var body: some View {
        CustomTabBar(selectedTab: $selectedTab)
    }
}
