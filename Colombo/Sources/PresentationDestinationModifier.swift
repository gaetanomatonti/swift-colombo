import SwiftUI

/// A view modifier that controls the presentation of a coordinator.
struct PresentationDestinationModifier<PresentedCoordinator, Router>: ViewModifier where Router: Colombo.Router, PresentedCoordinator: NavigationCoordinator<Router> {

  // MARK: - Computed Properties

  @Environment(\.presentationCoordinator) var presentingCoordinator
  
  @Environment(\.route) var route
  
  private var sheetPresentation: Binding<Presentation?> {
    Binding {
      guard canPresent else {
        return nil
      }
      
      return presentingCoordinator?.sheetPresentation
    } set: { newValue in
      presentingCoordinator?.sheetPresentation = newValue
    }
  }
  
  private var fullScreenCoverPresentation: Binding<Presentation?> {
    Binding {
      guard canPresent else {
        return nil
      }
      
      return presentingCoordinator?.fullScreenCoverPresentation
    } set: { newValue in
      presentingCoordinator?.fullScreenCoverPresentation = newValue
    }
  }

  /// Whether the `PresentingCoordinator` can present the `PresentedCoordinator`.
  ///
  /// This property checks that the ``Presentation`` of the `presentingCoordinator` contains the identifier of the `PresentedCoordinator`.
  /// - Note: This check is needed to make sure that the `PresentedCoordinator` is to be presented and is actually contained in the storage.
  private var canPresent: Bool {
    guard let route else {
      fatalError("Expected a `Route` associated to the view.")
    }
    
    guard let presentingCoordinator else {
      fatalError("Expected a `PresentingCoordinator` to be present.")
    }
    
    guard let presentation = presentingCoordinator.presentation else {
      return false
    }
    
    let presentedIdentifierMatchesPresentation = PresentedCoordinator.id == presentation.coordinatorID
    
    if let navigationCoordinator = presentingCoordinator as? (any NavigationCoordinatorProtocol) {
      if let lastRoute = navigationCoordinator.peekRoute() {
        let isLastRouteInStack = lastRoute.hashValue == route.hashValue
        return isLastRouteInStack && presentedIdentifierMatchesPresentation
      } else {
        let isRoot = navigationCoordinator.root.hashValue == route.hashValue
        return isRoot && presentedIdentifierMatchesPresentation
      }
    }

    return presentedIdentifierMatchesPresentation
  }

  // MARK: - Body

  @ViewBuilder
  func body(content: Content) -> some View {
    if let presentingCoordinator {
      @Bindable var presentingCoordinator = presentingCoordinator

      content
        .sheet(item: sheetPresentation) { presentation in
          CoordinatedNavigationView<PresentedCoordinator, Router>()
            .presentationCornerRadius(presentation.style.cornerRadius)
            .presentationDetents(presentation.style.presentationDetents)
            .presentationDragIndicator(presentation.style.dragIndicatorVisibility)
            .interactiveDismissDisabled(presentation.style.isInteractiveDismissDisabled)
        }
        .fullScreenCover(item: fullScreenCoverPresentation) { _ in
          CoordinatedNavigationView<PresentedCoordinator, Router>()
        }
    } else {
      content
    }
  }
}
