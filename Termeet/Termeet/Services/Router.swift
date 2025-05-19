import SwiftUI

enum Route: Hashable, Identifiable {

    case detail
    case settings

    // MARK: - for passwordRecoveryView
    case passwordRecoveryInputEmail
    case passwordRecoverySendingLetter
    case passwordRecoveryInputNewPassword

    var id: String {
        String(describing: self)
    }
}

final class Router: ObservableObject {
    @Published var path = NavigationPath()
    @Published var presentedSheet: Route?
    private var lastAppendedRoute: Route?

    func navigate(to route: Route) {
        if lastAppendedRoute != route {
            lastAppendedRoute = route
            path.append(route)
        }
    }

    func present(route: Route) {
        presentedSheet = route
    }

    func dismiss() {
        presentedSheet = nil
    }

    func popToRoot() {
        path = NavigationPath()
    }
}
