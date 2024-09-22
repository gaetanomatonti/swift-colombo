import SwiftUI

public struct CoordinatedView<C>: View where C: Coordinator {

  // MARK: - Computed Properties

  let coordinator: C

  // MARK: - Init

  public init(coordinator: C) {
    self.coordinator = coordinator
  }

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

/*

 CoordinatedTabView($tabCoordinator)

 final class AppTabCoordinator {
  var tabs: [TabCoordinator] = [...]

  var selection: TabCoordinator?
 }
 */
