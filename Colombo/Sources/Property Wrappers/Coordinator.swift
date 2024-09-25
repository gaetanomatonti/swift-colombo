import Foundation

/// A property wrapper that can read and write a coordinator object in shared storage.
///
/// Use this property wrapper to add a coordinator in the shared storage, or read a coordinator instance.
@propertyWrapper
@MainActor
public struct Coordinator<Value> where Value: CoordinatorProtocol {
  
  // MARK: - Stored Properties
  
  public let wrappedValue: Value

  // MARK: - Init
  
  /// Reads the instance of the coordinator of the passed type.
  public init(_ value: Value.Type) {
    wrappedValue = CoordinatorStorage.shared.coordinator(value)
  }

  /// Creates an instance of a coordinator and writes it in the shared storage.
  public init(wrappedValue: Value) {
    self.wrappedValue = wrappedValue
    CoordinatorStorage.shared.add(wrappedValue)
  }
}
