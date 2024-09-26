import Foundation

/// A property wrapper that can read and write a coordinator object in shared storage.
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
