import Foundation

extension Array where Element: Route {
  func contains(_ route: Element) -> Bool {
    contains { $0 == route }
  }
}
