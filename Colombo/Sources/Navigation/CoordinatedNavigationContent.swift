import SwiftUI

/// A view that can be used as content for a `NavigationStack` whose navigation is managed by a ``NavigationCoordinator``.
///
/// - Note: This type is not meant to be initialized directly. Use `NavigationStack(_ coordinator: NavigationCoordinator.Type)` instead.
public struct CoordinatedNavigationContent<NavigationCoordinator, Router>: View where Router: Colombo.Router, NavigationCoordinator: Colombo.NavigationCoordinator<Router> {
  
  // MARK: - Computed Properties
  
  /// The coordinator of the view.
  @Coordinator(NavigationCoordinator.self) var coordinator
  
  // MARK: - Init
  
  init() {}
  
  // MARK: - Body

  public var body: some View {
    coordinator.router.destination(for: coordinator.root)
      .route(coordinator.root)
      .presentationCoordinator(NavigationCoordinator.self)
      .navigationDestination(for: NavigationCoordinator.Route.self) { route in
        coordinator.router.destination(for: route)
          .route(route)
          .presentationCoordinator(NavigationCoordinator.self)
      }
  }
}
