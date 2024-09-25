import Foundation

/// A type erased ``Route``.
struct AnyRoute {
  
  // MARK: - Stored Properties
  
  /// The wrapped route.
  let route: any Route
}

extension AnyRoute: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(route)
  }
}

extension AnyRoute: Equatable {
  static func == (lhs: AnyRoute, rhs: AnyRoute) -> Bool {
    lhs.route.hashValue == rhs.route.hashValue
  }
}
