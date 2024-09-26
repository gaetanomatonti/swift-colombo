import Foundation
import SwiftUI

/// A protocol that defines requirements for an object that coordinates navigation.
@MainActor
public protocol CoordinatorProtocol: AnyObject, Identifiable, Observable {}

public extension CoordinatorProtocol {
  nonisolated var id: ObjectIdentifier {
    Self.id
  }

  nonisolated static var id: ObjectIdentifier {
    ObjectIdentifier(self)
  }
}
