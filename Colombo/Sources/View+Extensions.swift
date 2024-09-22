import SwiftUI

extension View {
  @ViewBuilder
  public func presentationDestination<PresentedCoordinator, PresentingCoordinator, R>(
    _ presentedCoordinator: PresentedCoordinator.Type,
    over presentingCoordinator: PresentingCoordinator.Type
  ) -> some View where R: Router, PresentedCoordinator: FlowCoordinator<R>, PresentingCoordinator: PresentableCoordinator {
    modifier(PresentationDestinationModifier<PresentedCoordinator, PresentingCoordinator, R>())
  }
}
