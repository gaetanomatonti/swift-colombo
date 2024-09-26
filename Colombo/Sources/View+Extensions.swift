import SwiftUI

extension View {
  /// Sets the destination for a presentation.
  /// - Parameters:
  ///   - presentedCoordinator: The type of the coordinator that can be presented as a destination.
  /// - Returns: A view that can control the presentation of the passed coordinator.
  @ViewBuilder
  public func presentationDestination<PresentedCoordinator, Router>(
    _ presentedCoordinator: PresentedCoordinator.Type
  ) -> some View where Router: Colombo.Router, PresentedCoordinator: NavigationCoordinator<Router> {
    modifier(PresentationDestinationModifier<PresentedCoordinator, Router>())
  }
}
