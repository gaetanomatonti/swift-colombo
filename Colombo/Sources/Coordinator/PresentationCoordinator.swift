import Foundation
import SwiftUI

/// A coordinator that is capable of presenting another coordinator.
@Observable
open class PresentationCoordinator: CoordinatorProtocol {

  // MARK: - Stored Properties

  /// The presentation on top of the current navigation flow.
  internal(set) public var presentation: Presentation? {
    didSet {
      if let oldValue, presentation == nil {
        dismiss(from: oldValue)
      }
    }
  }

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

  /// Dismisses the coordinator in the current presentation.
  /// - Parameter presentation: The presentation of the coordinator.
  private func dismiss(from presentation: Presentation) {
    CoordinatorStorage.shared.remove(presentation.coordinatorID)
  }
}

@MainActor
extension PresentationCoordinator {
  /// The sheet presentation on top of the current navigation.
  ///
  /// This value is optional, and only has a value if the style of the presentation is `.sheet`.
  var sheetPresentation: Presentation? {
    get {
      if case .sheet = presentation?.style.id {
        return presentation
      } else {
        return nil
      }
    }
    set {
      presentation = newValue
    }
  }

  /// The sheet presentation on top of the current navigation.
  ///
  /// This value is optional, and only has a value if the style of the presentation is `.fullScreenCover`.
  var fullScreenCoverPresentation: Presentation? {
    get {
      if case .fullScreenCover = presentation?.style.id {
        return presentation
      } else {
        return nil
      }
    }
    set {
      presentation = newValue
    }
  }
}
