import SwiftUI

public struct CoordinatedView<C>: View where C: Coordinator {

  // MARK: - Computed Properties

  @Binding var coordinator: C

  // MARK: - Init

  public init(coordinator: Binding<C>) {
    self._coordinator = coordinator
  }

  // MARK: - Body

  public var body: some View {
    NavigationStack(path: $coordinator.path) {
      coordinator.destination(for: coordinator.root)
        .navigationDestination(for: C.Route.self) { route in
          coordinator.destination(for: route)
        }
        .presentation(item: $coordinator.presentation)
    }
    .environment(coordinator)
  }
}

public struct AnyCoordinatedView: View {

  // MARK: - Computed Properties

  @Binding var coordinator: any Coordinator

  // MARK: - Init

  public init(coordinator: Binding<any Coordinator>) {
    self._coordinator = coordinator
  }

  // MARK: - Body

  public var body: some View {
    AnyView(
      NavigationStack(path: $coordinator.path) {
        AnyView(
          coordinator.destination(for: coordinator.root)
            .navigationDestination(for: type(of: coordinator).Route.self) { route in
              AnyView(coordinator.destination(for: route))
            }
            .presentation(item: $coordinator.presentation)
        )
      }
      .environment(coordinator)
    )
  }
}
