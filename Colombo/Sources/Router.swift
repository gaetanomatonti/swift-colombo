import Foundation
import SwiftUI

public protocol Router {
  associatedtype Destination: View

  associatedtype _Route: Route

  @ViewBuilder
  func destination(for route: _Route) -> Destination
}
