import SwiftUI

public struct Presentation: Identifiable {
  public enum Style: String, Hashable, Identifiable {
    case sheet
    case fullScreenCover

    public var id: String {
      rawValue
    }
  }

  let style: Style

  let coordinatorID: ObjectIdentifier

  init<C>(style: Style, coordinator: C) where C: Coordinator {
    self.style = style
    self.coordinatorID = C.id
  }

  public var id: String {
    "\(style.id)_\(coordinatorID.hashValue)"
  }
}

extension Binding where Value == Presentation? {
  var sheet: Binding<Presentation?> {
    if case .sheet = wrappedValue?.style {
      return self
    }

    return .constant(nil)
  }

  var fullScreenCover: Binding<Presentation?> {
    if case .fullScreenCover = wrappedValue?.style {
      return self
    }

    return .constant(nil)
  }
}
