import Foundation
import SwiftUI
import UIKit

/// A protocol defining requirements for types that identify a navigation route.
public protocol Route: Hashable {}

extension EnvironmentValues {
  @Entry var route: AnyRoute? = nil
}

extension View {
  func route<R>(_ route: R) -> some View where R: Route {
    modifier(RouteModifier(route: route))
  }
}

struct RouteModifier<R: Route>: ViewModifier {
  let route: R
  
  func body(content: Content) -> some View {
    content
      .environment(\.route, AnyRoute(route: route))
  }
}
