import SwiftUI

public struct CoordinatedView<C, R>: View where R: Router, C: FlowCoordinator<R> {

  @CoordinatorObject(C.self) var coordinator

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
    .environment(coordinator)
  }
}
