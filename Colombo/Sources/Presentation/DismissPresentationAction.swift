import Foundation
import SwiftUI

/// An action that dismisses a presentation.
public struct DismissPresentationAction: Sendable {
  
  // MARK: - Stored Properties

  /// The action to dismiss the presentation.
  let action: @MainActor () -> Void
  
  // MARK: Init
  
  public init(action: @MainActor @escaping () -> Void) {
    self.action = action
  }
  
  // MARK: - Functions
  
  @MainActor
  public func callAsFunction() {
    action()
  }
}

// MARK: - Environment

#if swift(>=6)
extension EnvironmentValues {
  /// An action that dismisses the current presentation.
  @Entry internal(set) public var dismissPresentation = DismissPresentationAction {}
}
#else
enum DismissPresentationActionKey: EnvironmentKey {
  static let defaultValue = DismissPresentationAction {}
}

extension EnvironmentValues {
  internal(set) public var dismissPresentation: DismissPresentationAction {
    get {
      self[DismissPresentationActionKey.self]
    }
    set {
      self[DismissPresentationActionKey.self] = newValue
    }
  }
}
#endif
