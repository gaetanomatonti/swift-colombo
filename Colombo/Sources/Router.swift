import Foundation
import SwiftUI

/// A protocol defining requirements for a type that defines the destinations for the specified routes.
public protocol Router {
  associatedtype Destination: View

  associatedtype Route: Colombo.Route

  /// Creates a destination for the passed route.
  /// - Parameter route: The route that identifies the destination.
  /// - Returns: The destination that matches the route.
  @ViewBuilder
  func destination(for route: Route) -> Destination
}
