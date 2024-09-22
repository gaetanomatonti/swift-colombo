import Foundation
import SwiftUI

/// A protocol that defines requirements for an object that coordinates navigation.
public protocol Coordinator: Observable, AnyObject, Identifiable where ID == ObjectIdentifier {}

public extension Coordinator {
  var id: ID {
    ObjectIdentifier(Self.self)
  }

  static var id: ID {
    ObjectIdentifier(self)
  }
}
