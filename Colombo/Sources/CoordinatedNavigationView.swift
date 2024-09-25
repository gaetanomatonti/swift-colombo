import SwiftUI

public struct CoordinatedNavigationContent<NavigationCoordinator, Router>: View where Router: Colombo.Router, NavigationCoordinator: Colombo.NavigationCoordinator<Router> {
  /// The coordinator of the view.
  @Coordinator(NavigationCoordinator.self) var coordinator

  public var body: some View {
    coordinator.router.destination(for: coordinator.root)
      .route(coordinator.root)
      .coordinator(NavigationCoordinator.self)
      .navigationDestination(for: NavigationCoordinator.Route.self) { route in
        coordinator.router.destination(for: route)
          .route(route)
          .coordinator(NavigationCoordinator.self)
      }
  }
}

@MainActor
public extension NavigationStack {
  init<NavigationCoordinator: Colombo.NavigationCoordinator<Router>, Router: Colombo.Router>(
    _ coordinator: NavigationCoordinator.Type
  ) where Data == Stack<Router.Route>, Root == CoordinatedNavigationContent<NavigationCoordinator, Router> {
    @Coordinator(NavigationCoordinator.self) var navigationCoordinator
    @Bindable var coordinator = navigationCoordinator
    
    self.init(path: $coordinator.path) {
      CoordinatedNavigationContent<NavigationCoordinator, Router>()
    }
  }
}

struct AnyRoute: Hashable {
  let route: any Route
  
  init(route: any Route) {
    self.route = route
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(route)
  }
  
  static func == (lhs: AnyRoute, rhs: AnyRoute) -> Bool {
    lhs.route.hashValue == rhs.route.hashValue
  }
}
