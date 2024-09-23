import SwiftUI

/// A view modifier that controls the presentation of a coordinator.
struct PresentationDestinationModifier<PresentedCoordinator, PresentingCoordinator, R>: ViewModifier where R: Router, PresentedCoordinator: FlowCoordinator<R>, PresentingCoordinator: PresentableCoordinator {

  // MARK: - Computed Property

  @Coordinator(PresentingCoordinator.self) var presentingCoordinator

  /// Whether the `PresentingCoordinator` can present the `PresentedCoordinator`.
  ///
  /// This property checks that the `Presentation` of the `PresentingCoordinator` contains the identifier of the `PresentingCoordinator`.
  /// - Note: This check is needed to make sure that the `PresentedCoordinator` is to be presented and is actually contained in the storage.
  var canPresent: Bool {
    guard let presentation = presentingCoordinator.presentation else {
      return false
    }
    
    return PresentedCoordinator.id == presentation.coordinatorID
  }

  // MARK: - Body

  func body(content: Content) -> some View {
    if canPresent {
      @Coordinator(PresentedCoordinator.self) var presentedCoordinator
      @Bindable var presentingCoordinator = presentingCoordinator

      content
        .sheet(item: $presentingCoordinator.presentation.sheet) {
          presentingCoordinator.dismiss(presentedCoordinator)
        } content: { item in
          CoordinatedView<PresentedCoordinator, R>()
        }
        .fullScreenCover(item: $presentingCoordinator.presentation.fullScreenCover) {
          presentingCoordinator.dismiss(presentedCoordinator)
        } content: { item in
          CoordinatedView<PresentedCoordinator, R>()
        }
    } else {
      content
    }
  }
}
