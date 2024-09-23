import SwiftUI

/// A view modifier that controls the presentation of a coordinator.
struct PresentationDestinationModifier<PresentedCoordinator, Router>: ViewModifier where Router: Colombo.Router, PresentedCoordinator: NavigationCoordinator<Router> {

  // MARK: - Computed Properties

  @Environment(\.presentationCoordinator) var presentingCoordinator

  /// A `Binding` to the presentation of the `presentingCoordinator`.
  private var presentation: Binding<Presentation?> {
    Binding {
      presentingCoordinator?.presentation
    } set: { newValue in
      presentingCoordinator?.presentation = newValue
    }
  }

  /// Whether the `PresentingCoordinator` can present the `PresentedCoordinator`.
  ///
  /// This property checks that the ``Presentation`` of the `presentingCoordinator` contains the identifier of the `PresentedCoordinator`.
  /// - Note: This check is needed to make sure that the `PresentedCoordinator` is to be presented and is actually contained in the storage.
  private var canPresent: Bool {
    guard let presentingCoordinator else {
      fatalError("Expected a `PresentingCoordinator` to be present.")
    }

    guard let presentation = presentingCoordinator.presentation else {
      return false
    }
    
    return PresentedCoordinator.id == presentation.coordinatorID
  }

  // MARK: - Body

  func body(content: Content) -> some View {
    if canPresent {
      content
        .sheet(item: presentation.sheet) { presentation in
          CoordinatedNavigationView<PresentedCoordinator, Router>()
            .presentationCornerRadius(presentation.style.cornerRadius)
            .presentationDetents(presentation.style.presentationDetents)
            .presentationDragIndicator(presentation.style.dragIndicatorVisibility)
            .interactiveDismissDisabled(presentation.style.isInteractiveDismissDisabled)
        }
        .fullScreenCover(item: presentation.fullScreenCover) { _ in
          CoordinatedNavigationView<PresentedCoordinator, Router>()
        }
    } else {
      content
    }
  }
}
