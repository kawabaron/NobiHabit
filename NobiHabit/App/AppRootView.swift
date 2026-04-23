import SwiftUI

struct AppRootView: View {
    @State private var selectedTab: AppTab = .home
    @State private var homePath: [AppRoute] = []
    @State private var menuPath: [AppRoute] = []
    @State private var recordPath: [AppRoute] = []
    @State private var settingsPath: [AppRoute] = []

    var body: some View {
        NavigationStack(path: pathBinding(for: selectedTab)) {
            selectedTab.content
                .withAppRoutes()
        }
        .id(selectedTab)
        .environment(\.navigate) { route in
            navigate(route, on: selectedTab)
        }
        .environment(\.returnHome, { returnHome() })
        .safeAreaInset(edge: .bottom, spacing: 0) {
            if showsTabBar {
                AppTabBar(selectedTab: $selectedTab)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .tint(AppColor.brandPrimarySage)
        .animation(.easeInOut(duration: 0.18), value: showsTabBar)
    }

    private var showsTabBar: Bool {
        switch selectedTab {
        case .home:
            homePath.isEmpty
        case .menu:
            menuPath.isEmpty
        case .record:
            recordPath.isEmpty
        case .settings:
            settingsPath.isEmpty
        }
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
