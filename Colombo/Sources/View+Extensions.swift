import SwiftUI

extension View {
  @ViewBuilder
  public func presentationDestination<PresentedCoordinator, PresentingCoordinator>(
    _ presentedCoordinator: PresentedCoordinator.Type,
    over presentingCoordinator: Binding<PresentingCoordinator>
  ) -> some View where PresentedCoordinator: Coordinator, PresentingCoordinator: Coordinator {
    let identifier = PresentedCoordinator.id

    if identifier == presentingCoordinator.presentation.wrappedValue?.coordinatorID {
      self
        .sheet(item: presentingCoordinator.presentation.sheet) { item in
          let presentedCoordinator = CoordinatorStorage.shared.coordinator(presentedCoordinator)
          CoordinatedView(coordinator: presentedCoordinator)
        }
        .fullScreenCover(item: presentingCoordinator.presentation.fullScreenCover) { item in
          let presentedCoordinator = CoordinatorStorage.shared.coordinator(presentedCoordinator)
          CoordinatedView(coordinator: presentedCoordinator)
        }
    } else {
      self
    }
  }
}
