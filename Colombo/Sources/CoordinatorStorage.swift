import Foundation

@Observable
final class CoordinatorStorage {
  private(set) var coordinators: [ObjectIdentifier: Any] = [:]

  func add<C>(_ coordinator: C) where C: Coordinator {
    coordinators[C.id] = coordinator
  }

  func remove<C>(_ coordinator: C) where C: Coordinator {
    coordinators.removeValue(forKey: C.id)
  }

  func remove(_ key: ObjectIdentifier) {
    coordinators.removeValue(forKey: key)
  }

  func coordinator<C>(_ key: C.Type) -> C where C: Coordinator {
    guard let coordinator = coordinators[C.id] as? C else {
      fatalError("Coordinator not found for \(key)")
    }

    return coordinator
  }
}

extension CoordinatorStorage {
  static let shared = CoordinatorStorage()
}

@propertyWrapper
struct CoordinatorObject<Value> where Value: Coordinator {
  let wrappedValue: Value

  init(_ value: Value.Type) {
    wrappedValue = CoordinatorStorage.shared.coordinator(value)
  }
}
