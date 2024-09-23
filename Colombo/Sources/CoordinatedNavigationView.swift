import SwiftUI

/// A view whose navigation is managed by a coordinator.
///
/// The content of this view must be managed by a ``FlowCoordinator``.
public struct CoordinatedNavigationView<C, R>: View where R: Router, C: NavigationCoordinator<R> {
  
  /// The coordinator of the view.
  @Coordinator(C.self) var coordinator

  // MARK: - Init

  public init() {}

  // MARK: - Body

  public var body: some View {
    @Bindable var coordinator = coordinator

    NavigationStack(path: $coordinator.path) {
      coordinator.router.destination(for: coordinator.root)
        .navigationDestination(for: C.Route.self) { route in
          coordinator.router.destination(for: route)
        }
    }
  }
}
