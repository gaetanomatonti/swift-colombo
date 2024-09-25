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

public struct CoordinatedNavigationRootModifier<Destination, NavigationCoordinator, Router>: ViewModifier where Destination: View, Router: Colombo.Router, NavigationCoordinator: Colombo.NavigationCoordinator<Router> {
  /// The coordinator of the view.
  @Coordinator(NavigationCoordinator.self) var coordinator

  let destination: (Router.Destination) -> Destination

  init(@ViewBuilder destination: @escaping (Router.Destination) -> Destination) {
    self.destination = destination
  }

  public func body(content: Content) -> some View {
    content
      .navigationDestination(for: NavigationCoordinator.Route.self) { route in
        destination(coordinator.router.destination(for: route))
      }
      .environment(\.presentationCoordinator, coordinator)
  }
}

public struct CoordinatedNavigationContent<NavigationCoordinator, Router>: View where Router: Colombo.Router, NavigationCoordinator: Colombo.NavigationCoordinator<Router> {
  /// The coordinator of the view.
  @Coordinator(NavigationCoordinator.self) var coordinator

  public var body: some View {
    coordinator.router.destinationWithRoute(for: coordinator.root)
      .navigationDestination(for: NavigationCoordinator.Route.self) { route in
        coordinator.router.destinationWithRoute(for: route)
      }
      .coordinator(NavigationCoordinator.self)
  }
}

@MainActor
public extension NavigationStack where Data == NavigationPath {
  init<NavigationCoordinator: Colombo.NavigationCoordinator<Router>, Router: Colombo.Router>(
    _ coordinator: NavigationCoordinator.Type
  ) where Root == CoordinatedNavigationContent<NavigationCoordinator, Router> {
    @Coordinator(NavigationCoordinator.self) var navigationCoordinator
    @Bindable var coordinator = navigationCoordinator
    
    self.init(path: $coordinator.path) {
      CoordinatedNavigationContent<NavigationCoordinator, Router>()
    }
  }
}
