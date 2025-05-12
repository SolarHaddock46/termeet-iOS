import SwiftUI

enum Route: Hashable, Identifiable {

    case detail
    case settings

    var id: String {
        switch self {
        case .detail: return "detail"
        case .settings: return "settings"
        }
    }
}

final class Router: ObservableObject {
    @Published var path = NavigationPath()
    @Published var presentedSheet: Route?
    private var lastAppendedRouter: Route?

    func navigate(to route: Route) {
        if lastAppendedRouter != route {
            lastAppendedRouter = route
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
