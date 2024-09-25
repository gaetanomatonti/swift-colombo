import Foundation
import OSLog
import SwiftUI

/// A coordinator that is capable of presenting another coordinator.
@Observable
open class PresentationCoordinator: CoordinatorProtocol {

  // MARK: - Stored Properties

  /// The presentation on top of the current navigation flow.
  internal(set) public var presentation: Presentation? {
    didSet {
      if let oldValue, presentation == nil {
        // Store the old value in a property when the current value is set to `nil`.
        _oldPresentation = oldValue
      }
    }
  }

  /// A copy of the old presentation value.
  ///
  /// Because of some issues with SwiftUI, this property is needed to properly handle the dismissal of sheets.
  ///
  /// When the content of a `sheet()` is contained in a `NavigationStack`, SwiftUI may set the value of the presentation `Binding` to `nil` **immediately** when the `dismiss()` action is called on the content view.
  /// Specifically, this happens when a navigation has occurred (i.e.: pushed another view) and a dismiss is attempted.
  ///
  /// To prevent the coordinator from clearing the presented coordinator from storage **before** the view is actually dismissed (since it could be redrawn, and may need access to its coordinator),
  /// we save a copy of the old value of the presentation.
  /// This allows us to call a method from the `onDismiss` callback of the `.sheet()` modifier, and properly dispose of the presented coordinator.
  private var _oldPresentation: Presentation?

  private let logger = Logger(subsystem: "com.gaetanomatonti.swift-colombo", category: "Presentation Coordinator")

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
    guard let currentPresentation = presentation else {
      return
    }

    dismiss(from: currentPresentation)
    presentation = nil
  }

  /// The action to execute when the dismiss of a presentation is complete.
  func onDismiss() {
    guard let _oldPresentation else {
      logger.warning("Expected to complete the dismiss for a presentation, but a copy of the old value is not available.")
      return
    }

    dismiss(from: _oldPresentation)
    presentation = nil

    logger.info("Completed dismiss for presentation \(_oldPresentation.id, privacy: .public)")
  }

  /// Dismisses the coordinator in the current presentation.
  /// - Parameter presentation: The presentation of the coordinator.
  private func dismiss(from presentation: Presentation) {
    CoordinatorStorage.shared.remove(presentation.coordinatorID)

    logger.info("Dismissed presentation \(presentation.id, privacy: .public)")
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
