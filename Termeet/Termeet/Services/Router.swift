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

    func navigate(to route: Route) {
        path.append(route)
    }

    func present(route: Route) {
        presentedSheet = route
    }

    func dismiss() {
        presentedSheet = nil
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}
