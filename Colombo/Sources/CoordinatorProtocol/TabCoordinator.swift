/// A coordinator that coordinates tabs in a tab view.
public protocol TabCoordinator: PresentableCoordinator {
  var tabs: [ObjectIdentifier] { get set }

  var selection: ObjectIdentifier? { get set }

  func register<C>(_ tab: C) where C: FlowCoordinator

  func select<C>(_ tab: C.Type) where C: FlowCoordinator
}

public extension TabCoordinator {
  func register<C>(_ tab: C) where C: FlowCoordinator {
    guard CoordinatorStorage.shared.coordinators[tab.id] == nil else {
      return
    }

    CoordinatorStorage.shared.add(tab)

    tabs.append(C.id)
  }

  func select<C>(_ tab: C.Type) where C: FlowCoordinator {
    selection = tab.id
  }
}
