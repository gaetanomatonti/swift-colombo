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

  let coordinator: any Coordinator

  public var id: String {
    "\(style.id)_\(coordinator.id.value)"
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
