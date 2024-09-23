import Foundation

/// An object to store coordinators.
@Observable
final class CoordinatorStorage {
  
  // MARK: - Stored Properties
  
  /// The dictionary of coordinators, keyed by their type identifier.
  private(set) var coordinators: [ObjectIdentifier: Any] = [:]
  
  // MARK: - Init
  
  private init() {}

  // MARK: - Functions
  
  /// Adds the instance of the coordinator to the shared storage.
  /// - Parameter coordinator: The instance of the coordinator to store.
  /// - Warning: This method has internal sanity checks to make sure a coordinator type cannot be stored twice.
  func add<C>(_ coordinator: C) where C: CoordinatorProtocol {
    assert(_coordinator(C.self) == nil)

    coordinators[C.id] = coordinator
  }

  /// Removes the coordinator keyed by the passed identifier from storage.
  /// - Parameter key: The identifier of the coordinator type.
  func remove(_ key: ObjectIdentifier) {
    coordinators.removeValue(forKey: key)
  }

  /// Reads and casts the instance of the coordinator of the passed type.
  /// - Parameter type: The type of the coordinator to read from storage.
  /// - Warning: This method throws a fatal error if the coordinator is not found in storage.
  /// - Returns: The casted coordinator.
  func coordinator<C>(_ key: C.Type) -> C where C: CoordinatorProtocol {
    guard let coordinator = _coordinator(key) else {
      fatalError("Coordinator not found for \(key)")
    }

    return coordinator
  }

  /// Reads and casts the instance of the coordinator of the passed type.
  /// - Parameter type: The type of the coordinator to read from storage.
  /// - Returns: An optional casted coordinator.
  private func _coordinator<C>(_ type: C.Type) -> C? where C: CoordinatorProtocol {
    coordinators[C.id] as? C
  }
}

extension CoordinatorStorage {
  /// A shared instance of the coordinator storage.
  static let shared = CoordinatorStorage()
}
