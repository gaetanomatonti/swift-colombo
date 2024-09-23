import Foundation

/// A coordinator that is capable of presenting another coordinator.
#warning("Rename to make it clearer that it can present, not that it can be presented.")
@Observable
open class PresentableCoordinator: CoordinatorProtocol {

  // MARK: - Stored Properties

  /// The presentation on top of the current navigation flow.
  internal(set) public var presentation: Presentation?

  // MARK: - Init

  public init(presentation: Presentation? = nil) {
    self.presentation = presentation
  }

  // MARK: - Functions

  /// Presents a new coordinator on top of the current navigation flow.
  /// - Parameters:
  ///   - coordinator: The coordinator to present modally.
  ///   - presentationStyle: The style of the modal presentation.
  public func present(_ coordinator: some CoordinatorProtocol, presentationStyle: Presentation.Style) {
    CoordinatorStorage.shared.add(coordinator)
    presentation = Presentation(style: presentationStyle, coordinator: coordinator)
  }

  /// Dismisses any coordinators presented on top of the current navigation flow.
  public func dismiss() {
    guard let presentation else {
      return
    }

    CoordinatorStorage.shared.remove(presentation.coordinatorID)
    self.presentation = nil
  }

  /// Dismisses any coordinators presented on top of the current navigation flow.
  func dismiss<C>(_ coordinator: C) where C: CoordinatorProtocol {
    guard let presentation else {
      CoordinatorStorage.shared.remove(coordinator.id)
      self.presentation = nil
      return
    }

    CoordinatorStorage.shared.remove(presentation.coordinatorID)
    self.presentation = nil
  }
}
