import SwiftUI

public extension View {
  @ViewBuilder
  func coordinator<Coordinator: Colombo.PresentationCoordinator>(_ coordinator: Coordinator.Type) -> some View {
    modifier(CoordinatorEnvironmentModifier<Coordinator>())
  }

  /// Sets the destination for a presentation.
  /// - Parameters:
  ///   - presentedCoordinator: The type of the coordinator that can be presented as a destination.
  /// - Returns: A view that can control the presentation of the passed coordinator.
  @ViewBuilder
  func presentationDestination<PresentedCoordinator, Router>(
    _ presentedCoordinator: PresentedCoordinator.Type
  ) -> some View where Router: Colombo.Router, PresentedCoordinator: NavigationCoordinator<Router> {
    modifier(PresentationDestinationModifier<PresentedCoordinator, Router>())
  }
}

struct CoordinatorEnvironmentModifier<PresentationCoordinator>: ViewModifier where PresentationCoordinator: Colombo.PresentationCoordinator {
  @Coordinator(PresentationCoordinator.self) var coordinator

  init() {}

  func body(content: Content) -> some View {
    content
      .environment(\.presentationCoordinator, coordinator)
  }
}
