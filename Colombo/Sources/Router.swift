import Foundation
import SwiftUI

public protocol Router {
  associatedtype Destination: View

  #warning("Make Hashable and remove _Screen.ID.")
  typealias Route = _Screen.ID

  @ViewBuilder
  func destination(for route: Route) -> Destination
}
