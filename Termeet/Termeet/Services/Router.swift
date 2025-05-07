import SwiftUI

enum Route {
    case main
    case detail
    //...
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
