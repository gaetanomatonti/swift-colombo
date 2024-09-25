import SwiftUI

/// A modifier that sets the presentation coordinator of the view.
struct PresentationCoordinatorModifier<PresentationCoordinator>: ViewModifier where PresentationCoordinator: Colombo.PresentationCoordinator {
  
  // MARK: - Computed Properties

  @Coordinator(PresentationCoordinator.self) var coordinator

  // MARK: - Init

  init() {}

  // MARK: - Body
  
  func body(content: Content) -> some View {
    content
      .environment(\.presentationCoordinator, coordinator)
  }
}
