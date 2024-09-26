import Foundation
import SwiftUI
import UIKit

/// A protocol defining requirements for types that identify a navigation route.
public protocol Route: Hashable, Identifiable {}

public extension Route {
  var id: Self {
    self
  }
}
