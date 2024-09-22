import SwiftUI

extension View {
  @ViewBuilder
  public func presentationDestination<PresentedCoordinator, PresentingCoordinator>(
    _ presentedCoordinator: PresentedCoordinator.Type,
    over presentingCoordinator: PresentingCoordinator.Type
  ) -> some View where PresentedCoordinator: FlowCoordinator, PresentingCoordinator: PresentableCoordinator {
    modifier(PresentationDestinationModifier<PresentedCoordinator, PresentingCoordinator>())
  }
}
