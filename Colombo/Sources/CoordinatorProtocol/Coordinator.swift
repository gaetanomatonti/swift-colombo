import Foundation
import SwiftUI

/// A protocol that defines requirements for an object that coordinates navigation.
@Observable
open class Coordinator: Identifiable {
  public var id: ID {
    ObjectIdentifier(Self.self)
  }

  static var id: ID {
    ObjectIdentifier(self)
  }
}
