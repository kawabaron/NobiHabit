import SwiftUI

struct AppRootView: View {
    @State private var selectedTab: AppTab = .home
    @State private var homePath: [AppRoute] = []
    @State private var menuPath: [AppRoute] = []
    @State private var recordPath: [AppRoute] = []
    @State private var settingsPath: [AppRoute] = []

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(AppTab.allCases) { tab in
                NavigationStack(path: pathBinding(for: tab)) {
                    tab.content
                        .withAppRoutes()
                }
                .environment(\.returnHome, { returnHome() })
                .tabItem {
                    tab.label
                }
                .tag(tab)
            }
        }
        .tint(AppColor.brandPrimarySage)
    }

    private func pathBinding(for tab: AppTab) -> Binding<[AppRoute]> {
        switch tab {
        case .home:
            $homePath
        case .menu:
            $menuPath
        case .record:
            $recordPath
        case .settings:
            $settingsPath
        }
    }

    private func returnHome() {
        homePath.removeAll()
        menuPath.removeAll()
        recordPath.removeAll()
        settingsPath.removeAll()
        selectedTab = .home
    }
}

#Preview {
    AppRootView()
}
