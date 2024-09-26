import SwiftUI

@MainActor
public extension NavigationStack {
  /// Creates an instance of a `NavigationStack` whose navigation is managed by a ``NavigationCoordinator``.
  /// - Parameter coordinator: The type of the coordinator that manages the navigation.
  init<NavigationCoordinator, Router>(
    _ coordinator: NavigationCoordinator.Type
  ) where Router: Colombo.Router, NavigationCoordinator: Colombo.NavigationCoordinator<Router>, Data == Stack<Router.Route>, Root == CoordinatedNavigationContent<NavigationCoordinator, Router> {
    @Coordinator(NavigationCoordinator.self) var navigationCoordinator
    @Bindable var coordinator = navigationCoordinator
    
    self.init(path: $coordinator.path) {
      CoordinatedNavigationContent<NavigationCoordinator, Router>()
    }
  }
}
