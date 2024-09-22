import SwiftUI

public struct CoordinatedView<C>: View where C: FlowCoordinator {

  @CoordinatorObject(C.self) var coordinator

  // MARK: - Init

  public init() {}

  // MARK: - Body

  public var body: some View {
    @Bindable var coordinator = coordinator

    NavigationStack(path: $coordinator.path) {
      coordinator.destination(for: coordinator.root)
        .navigationDestination(for: C.Route.self) { route in
          coordinator.destination(for: route)
        }
    }
    .environment(coordinator)
  }
}
