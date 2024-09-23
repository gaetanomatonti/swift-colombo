import SwiftUI

/// A type that represents a coordinator presentation.
public struct Presentation: Identifiable {
  /// The style of the presentation.
  let style: Style

  /// The identifier of the presented coordinator.
  let coordinatorID: ObjectIdentifier

  public var id: String {
    "\(style.id)_\(coordinatorID.hashValue)"
  }

  init<C>(style: Style, coordinator: C) where C: CoordinatorProtocol {
    self.style = style
    self.coordinatorID = C.id
  }
}

extension Presentation {
  /// The style of the presentation.
  public struct Style: Identifiable {
    /// The identifier of the presentation style.
    public enum ID: String, Hashable, Identifiable {
      /// A customizable sheet presentation.
      case sheet
      
      /// A full screen presentation.
      case fullScreenCover

      public var id: String {
        rawValue
      }
    }
    
    /// The corner radius of the sheet.
    let cornerRadius: CGFloat?
    
    /// The possible detents of the sheet.
    let presentationDetents: Set<PresentationDetent>
    
    /// The visibility of the drag indicator.
    let dragIndicatorVisibility: Visibility

    #warning("Defaults to true because of a bug with interactive dismiss.")
    let isInteractiveDismissDisabled: Bool = true

    public let id: ID
    
    init(
      _ id: ID,
      cornerRadius: CGFloat? = nil,
      presentationDetents: Set<PresentationDetent> = [],
      dragIndicatorVisibility: Visibility = .automatic
    ) {
      self.id = id
      self.cornerRadius = cornerRadius
      self.presentationDetents = presentationDetents
      self.dragIndicatorVisibility = dragIndicatorVisibility
    }
  }
}

public extension Presentation.Style {
  /// A sheet presentation with default styling.
  static let sheet = Presentation.Style(.sheet)
  
  /// A full screen presentation.
  static let fullScreenCover = Presentation.Style(.fullScreenCover)
  
  /// Creates a customizable sheet presentation.
  /// - Parameters:
  ///   - cornerRadius: The corner radius of the presentation. Setting this to `nil` defaults to the default value.
  ///   - presentationDetents: The detents of the presentation.
  ///   - dragIndicatorVisibility: The visibility of the drag indicator.
  /// - Returns: The customized sheet presentation.
  static func sheet(
    cornerRadius: CGFloat? = nil,
    presentationDetents: Set<PresentationDetent> = [],
    dragIndicatorVisibility: Visibility = .automatic
  ) -> Presentation.Style {
    Presentation.Style(
      .sheet,
      cornerRadius: cornerRadius,
      presentationDetents: presentationDetents,
      dragIndicatorVisibility: dragIndicatorVisibility
    )
  }
}

extension Binding where Value == Presentation? {
  var sheet: Binding<Presentation?> {
    if case .sheet = wrappedValue?.style.id {
      return self
    }

    return .constant(nil)
  }

  var fullScreenCover: Binding<Presentation?> {
    if case .fullScreenCover = wrappedValue?.style.id {
      return self
    }

    return .constant(nil)
  }
}
