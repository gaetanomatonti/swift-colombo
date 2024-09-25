import SwiftUI

extension View {
  /// Sets the presentation coordinator of the view.
  /// - Parameter coordinator: The type of ``PresentationCoordinator`` that manages the presentations on the view.
  func presentationCoordinator<Coordinator: Colombo.PresentationCoordinator>(_ coordinator: Coordinator.Type) -> some View {
    modifier(PresentationCoordinatorModifier<Coordinator>())
  }
}
