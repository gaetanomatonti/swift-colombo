import Foundation
import SwiftUI
import UIKit

/// A protocol defining requirements for types that identify a navigation route.
public protocol Route: Hashable {}

extension EnvironmentValues {
  @Entry var route: (any Route)? = nil
}

extension View {
  func route<R>(_ route: R) -> some View where R: Route {
    environment(\.route, route)
  }
}
