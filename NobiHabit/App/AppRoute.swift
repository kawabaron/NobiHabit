import SwiftUI

enum AppRoute: Hashable {
    case sessionPrep(StretchRoutine)
    case activeSession(StretchRoutine)
}

extension View {
    func withAppRoutes() -> some View {
        navigationDestination(for: AppRoute.self) { route in
            switch route {
            case .sessionPrep(let routine):
                SessionPrepScreen(routine: routine)
            case .activeSession(let routine):
                ActiveSessionScreen(routine: routine)
            }
        }
    }
}
