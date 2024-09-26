import Foundation

extension Array where Element: Equatable {
  func contains(_ element: Element) -> Bool {
    contains { $0 == element }
  }
}
