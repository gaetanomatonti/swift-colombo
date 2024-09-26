import SwiftUI

extension View {
  /// Sets the route of the view.
  /// - Parameter route: The ``Route`` associated to the view.
  func route<R>(_ route: R) -> some View where R: Route {
    environment(\.route, AnyRoute(route: route))
  }
}
