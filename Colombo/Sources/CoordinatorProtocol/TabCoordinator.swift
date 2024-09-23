import Foundation

/// A coordinator that coordinates tabs in a tab view.
@Observable
open class TabCoordinator: PresentationCoordinator {
  
  // MARK: - Stored Properties
  
  /// The coordinator set as tabs.
  #warning("Change into an ordered set.")
  var tabs: [ObjectIdentifier]

  /// The identifier of the selected coordinator.
  #warning("Fix selection when building with Xcode 15.")
  public var selection: ObjectIdentifier?

  // MARK: - Init
  
  public init() {
    self.tabs = []
    self.selection = nil
  }
  
  // MARK: - Functions

  public func register<Coordinator, Router>(_ tab: Coordinator) where Router: Colombo.Router, Coordinator: NavigationCoordinator<Router> {
    guard CoordinatorStorage.shared.coordinators[tab.id] == nil else {
      return
    }

    CoordinatorStorage.shared.add(tab)

    tabs.append(Coordinator.id)

    if selection == nil {
      select(Coordinator.self)
    }
  }

  public func select<Coordinator, Router>(_ tab: Coordinator.Type) where Router: Colombo.Router, Coordinator: NavigationCoordinator<Router> {
    guard tabs.contains(where: { $0 == tab.id }) else {
      fatalError("Attempted to select an unregistered tab.")
    }
    
    selection = tab.id
  }
}
