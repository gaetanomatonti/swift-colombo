/// A coordinator that is capable of presenting another coordinator.
#warning("Rename to make it clearer that it can present, not that it can be presented.")
public protocol PresentableCoordinator: Coordinator {
  /// The presentation on top of the current navigation flow.
  var presentation: Presentation? { get set }

  func present(_ coordinator: some Coordinator, presentationStyle: Presentation.Style)

  func dismiss<C>(_ coordinator: C) where C: Coordinator
}

public extension PresentableCoordinator {
  /// Presents a new coordinator on top of the current navigation flow.
  /// - Parameters:
  ///   - coordinator: The coordinator to present modally.
  ///   - presentationStyle: The style of the modal presentation.
  func present(_ coordinator: some Coordinator, presentationStyle: Presentation.Style) {
    CoordinatorStorage.shared.add(coordinator)
    presentation = Presentation(style: presentationStyle, coordinator: coordinator)
  }

  /// Dismisses any coordinators presented on top of the current navigation flow.
  func dismiss<C>(_ coordinator: C) where C: Coordinator {
    guard let presentation else {
      CoordinatorStorage.shared.remove(coordinator.id)
      self.presentation = nil
      return
    }

    CoordinatorStorage.shared.remove(presentation.coordinatorID)
    self.presentation = nil
  }
}
