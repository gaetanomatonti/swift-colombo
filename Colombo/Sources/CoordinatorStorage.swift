import Foundation

/// An object to store coordinators.
@Observable
final class CoordinatorStorage {
  
  // MARK: - Stored Properties

  /// The identifier of the root coordinator of the application.
  private(set) var rootCoordinator: ObjectIdentifier?

  /// The dictionary of coordinators, keyed by their type identifier.
  private(set) var coordinators: [ObjectIdentifier: Any] = [:]

  // MARK: - Init
  
  private init() {}

  // MARK: - Functions

  func set<Coordinator>(root coordinator: Coordinator) where Coordinator: CoordinatorProtocol {
    assert(rootCoordinator == nil, "Attempted to set a root coordinator more than once.")

    add(coordinator)
    rootCoordinator = coordinator.id
  }

  /// Adds the instance of the coordinator to the shared storage.
  /// - Parameter coordinator: The instance of the coordinator to store.
  /// - Warning: This method has internal sanity checks to make sure a coordinator type cannot be stored twice.
  func add<Coordinator>(_ coordinator: Coordinator) where Coordinator: CoordinatorProtocol {
    assert(_coordinator(Coordinator.self) == nil, "Attempted to insert a coordinator more than once.")

    coordinators[Coordinator.id] = coordinator
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
  func coordinator<Coordinator>(_ key: Coordinator.Type) -> Coordinator where Coordinator: CoordinatorProtocol {
    guard let coordinator = _coordinator(key) else {
      fatalError("Coordinator not found for \(key)")
    }

    return coordinator
  }

  /// Reads and casts the instance of the coordinator of the passed type.
  /// - Parameter type: The type of the coordinator to read from storage.
  /// - Returns: An optional casted coordinator.
  private func _coordinator<Coordinator>(_ type: Coordinator.Type) -> Coordinator? where Coordinator: CoordinatorProtocol {
    coordinators[Coordinator.id] as? Coordinator
  }
}

extension CoordinatorStorage {
  /// A shared instance of the coordinator storage.
  static let shared = CoordinatorStorage()
}
