import Foundation
import SwiftUI

/// A protocol that defines requirements for an object that coordinates navigation.
public protocol CoordinatorProtocol: AnyObject, Identifiable, Observable {}

public extension CoordinatorProtocol {
  var id: ObjectIdentifier {
    Self.id
  }

  static var id: ObjectIdentifier {
    ObjectIdentifier(self)
  }
}
