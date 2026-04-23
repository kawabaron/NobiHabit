import SwiftUI

struct AppRootView: View {
    @State private var selectedTab: AppTab = .home

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(AppTab.allCases) { tab in
                NavigationStack {
                    tab.content
                }
                .tabItem {
                    tab.label
                }
                .tag(tab)
            }
        }
        .tint(AppColor.brandPrimarySage)
    }
}

#Preview {
    AppRootView()
}
