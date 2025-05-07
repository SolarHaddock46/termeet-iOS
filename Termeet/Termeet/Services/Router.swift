import SwiftUI

enum Route: Hashable {
    case detail
    case settings
}

final class Router: ObservableObject {
    @Published var path = NavigationPath()

    func navigate(to route: Route) {
        path.append(route)
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}
