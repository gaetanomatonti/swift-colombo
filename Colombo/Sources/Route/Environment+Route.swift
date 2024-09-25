import SwiftUI

#if swift(>=6)
extension EnvironmentValues {
  /// The route associated to the view.
  @Entry var route: AnyRoute? = nil
}
#else
enum RouteKey: EnvironmentKey {
  static let defaultValue: AnyRoute? = nil
}

extension EnvironmentValues {
  /// A reference to the presentation coordinator of the view.
  var route: AnyRoute? {
    get {
      self[RouteKey.self]
    }
    set {
      self[RouteKey.self] = newValue
    }
  }
}
#endif
