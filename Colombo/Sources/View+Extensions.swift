import SwiftUI

extension View {
  /// Sets the destination for a presentation.
  /// - Parameters:
  ///   - presentedCoordinator: The type of the coordinator that can be presented as a destination.
  ///   - presentingCoordinator: The coordinator that controls the presentation.
  /// - Returns: A view that can control the presentation of the passed coordinator.
  @ViewBuilder
  public func presentationDestination<PresentedCoordinator, PresentingCoordinator, R>(
    _ presentedCoordinator: PresentedCoordinator.Type,
    over presentingCoordinator: PresentingCoordinator.Type
  ) -> some View where R: Router, PresentedCoordinator: NavigationCoordinator<R>, PresentingCoordinator: PresentationCoordinator {
    modifier(PresentationDestinationModifier<PresentedCoordinator, PresentingCoordinator, R>())
  }
}
