import SwiftUI

enum AppTab: String, CaseIterable, Identifiable, Hashable {
    case home
    case menu
    case record
    case settings

    var id: String { rawValue }

    @ViewBuilder
    var content: some View {
        switch self {
        case .home:
            HomeScreen()
        case .menu:
            MenuLibraryScreen()
        case .record:
            RecordPlaceholderScreen()
        case .settings:
            SettingsScreen()
        }
    }

    @ViewBuilder
    var label: some View {
        switch self {
        case .home:
            Label("ホーム", systemImage: "house")
        case .menu:
            Label("メニュー", systemImage: "list.bullet")
        case .record:
            Label("記録", systemImage: "moon.stars")
        case .settings:
            Label("設定", systemImage: "gearshape")
        }
    }
}
