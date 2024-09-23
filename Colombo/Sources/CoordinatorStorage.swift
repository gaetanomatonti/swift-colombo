import Foundation

@Observable
final class CoordinatorStorage {
  private(set) var coordinators: [ObjectIdentifier: Any] = [:]

  func add<C>(_ coordinator: C) where C: CoordinatorProtocol {
    assert(_coordinator(C.self) == nil)

    coordinators[C.id] = coordinator
  }

  func remove<C>(_ coordinator: C) where C: CoordinatorProtocol {
    coordinators.removeValue(forKey: C.id)
  }

  func remove(_ key: ObjectIdentifier) {
    coordinators.removeValue(forKey: key)
  }

  func coordinator<C>(_ key: C.Type) -> C where C: CoordinatorProtocol {
    guard let coordinator = _coordinator(key) else {
      fatalError("Coordinator not found for \(key)")
    }

    return coordinator
  }

  private func _coordinator<C>(_ key: C.Type) -> C? where C: CoordinatorProtocol {
    coordinators[C.id] as? C
  }
}

extension CoordinatorStorage {
  static let shared = CoordinatorStorage()
}
