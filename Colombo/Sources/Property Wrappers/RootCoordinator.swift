import Foundation

/// A property wrapper that can write a coordinator object in shared storage.
///
/// Use this property wrapper to set the root coordinator of your application.
///
/// - Note: This property wrapper is meant to be used only once throughout the lifecycle of the application.
///         Calling this property wrapper multiple times results in a fatal error.
@propertyWrapper
@MainActor
public struct RootCoordinator<Value> where Value: CoordinatorProtocol {

  // MARK: - Stored Properties

  public let wrappedValue: Value

  // MARK: - Init

  /// Creates an instance of a coordinator and writes it in the shared storage.
  public init(wrappedValue: Value) {
    self.wrappedValue = wrappedValue
    CoordinatorStorage.shared.set(root: wrappedValue)
  }
}
