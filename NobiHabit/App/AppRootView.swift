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
                .environment(\.navigate) { route in
                    navigate(route, on: tab)
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

    private func navigate(_ route: AppRoute, on tab: AppTab) {
        switch tab {
        case .home:
            homePath.append(route)
        case .menu:
            menuPath.append(route)
        case .record:
            recordPath.append(route)
        case .settings:
            settingsPath.append(route)
        }
    }
}

#Preview {
    AppRootView()
}
