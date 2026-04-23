import SwiftUI

enum AppTab: String, CaseIterable, Identifiable, Hashable {
    case home
    case menu
    case record
    case settings

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home:
            "ホーム"
        case .menu:
            "メニュー"
        case .record:
            "記録"
        case .settings:
            "設定"
        }
    }

    var systemImage: String {
        switch self {
        case .home:
            "house"
        case .menu:
            "list.bullet"
        case .record:
            "moon.stars"
        case .settings:
            "gearshape"
        }
    }

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
        Label {
            Text(title)
        } icon: {
            Image(systemName: systemImage)
        }
    }
}
