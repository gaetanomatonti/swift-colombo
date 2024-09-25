import Foundation
import SwiftUI

/// A protocol defining requirements for a type that defines the destinations for the specified routes.
@MainActor
public protocol Router {
  associatedtype Destination: View

  associatedtype Route: Colombo.Route

  /// Creates a destination for the passed route.
  /// - Parameter route: The route that identifies the destination.
  /// - Returns: The destination that matches the route.
  @ViewBuilder
  func destination(for route: Route) -> Destination
}

@MainActor
extension Router {
  @ViewBuilder
  func destinationWithRoute(for route: Route) -> some View {
    destination(for: route)
      .environment(\.route, route)
  }
}
