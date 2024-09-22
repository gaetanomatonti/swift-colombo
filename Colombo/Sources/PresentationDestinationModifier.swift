import SwiftUI

/// A view modifier that controls the presentation of a coordinator.
struct PresentationDestinationModifier<PresentedCoordinator, PresentingCoordinator>: ViewModifier where PresentedCoordinator: FlowCoordinator, PresentingCoordinator: PresentableCoordinator {

  // MARK: - Computed Property

  @CoordinatorObject(PresentingCoordinator.self) var presentingCoordinator

  /// Whether the `PresentingCoordinator` can present the `PresentedCoordinator`.
  ///
  /// This property checks that the `Presentation` of the `PresentingCoordinator` contains the identifier of the `PresentingCoordinator`.
  /// - Note: This check is needed to make sure that the `PresentedCoordinator` is to be presented and is actually contained in the storage.
  var canPresent: Bool {
    PresentedCoordinator.id == presentingCoordinator.presentation?.coordinatorID
  }

  // MARK: - Body

  func body(content: Content) -> some View {
    if canPresent {
      @CoordinatorObject(PresentedCoordinator.self) var presentedCoordinator
      @Bindable var presentingCoordinator = presentingCoordinator

      content
        .sheet(item: $presentingCoordinator.presentation.sheet) {
          presentingCoordinator.dismiss(presentedCoordinator)
        } content: { item in
          CoordinatedView<PresentedCoordinator>()
        }
        .fullScreenCover(item: $presentingCoordinator.presentation.fullScreenCover) {
          presentingCoordinator.dismiss(presentedCoordinator)
        } content: { item in
          CoordinatedView<PresentedCoordinator>()
        }
    } else {
      content
    }
  }
}
