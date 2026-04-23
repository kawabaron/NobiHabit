import SwiftUI

enum AppRoute: Hashable {
    case sessionPrep(StretchRoutine)
    case activeSession(StretchRoutine)
    case completion(StretchRoutine)
}

extension View {
    func withAppRoutes() -> some View {
        navigationDestination(for: AppRoute.self) { route in
            switch route {
            case .sessionPrep(let routine):
                SessionPrepScreen(routine: routine)
            case .activeSession(let routine):
                ActiveSessionScreen(routine: routine)
            case .completion(let routine):
                CompletionScreen(routine: routine)
            }
        }
    }
}

private struct ReturnHomeKey: EnvironmentKey {
    static let defaultValue: () -> Void = {}
}

extension EnvironmentValues {
    var returnHome: () -> Void {
        get { self[ReturnHomeKey.self] }
        set { self[ReturnHomeKey.self] = newValue }
    }
}
