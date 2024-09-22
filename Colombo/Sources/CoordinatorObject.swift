import Foundation

/// A property wrapper that can read and write a coordinator object in shared storage.
@propertyWrapper
public struct CoordinatorObject<Value> where Value: Coordinator {
  public let wrappedValue: Value

  public init(_ value: Value.Type) {
    wrappedValue = CoordinatorStorage.shared.coordinator(value)
  }

  public init(wrappedValue: Value) {
    self.wrappedValue = wrappedValue
    CoordinatorStorage.shared.add(wrappedValue)
  }
}
