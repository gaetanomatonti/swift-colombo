import SwiftUI

/// A view whose navigation is managed by a coordinator.
///
/// The content of this view must be managed by a ``NavigationCoordinator``.
public struct CoordinatedNavigationView<NavigationCoordinator, Router>: View where Router: Colombo.Router, NavigationCoordinator: Colombo.NavigationCoordinator<Router> {

  /// The coordinator of the view.
  @Coordinator(NavigationCoordinator.self) var coordinator

  // MARK: - Init

  public init() {}

  // MARK: - Body

  public var body: some View {
    @Bindable var coordinator = coordinator

    NavigationStack(path: $coordinator.path) {
      coordinator.router.destination(for: coordinator.root)
        .navigationDestination(for: NavigationCoordinator.Route.self) { route in
          coordinator.router.destination(for: route)
        }
    }
  }
}

//extension NavigationStack {
//  init<NavigationCoordinator, Router>(_ coordinator: NavigationCoordinator.Type) where Router: Colombo.Router, NavigationCoordinator: Colombo.NavigationCoordinator<Router> {
//    @Coordinator(NavigationCoordinator.self) var navigationCoordinator
//    @Bindable var coordinator = navigationCoordinator
//    
//    self = NavigationStack(path: $coordinator.path) {
//      coordinator.router.destination(for: coordinator.root)
//    }
//  }
//}
