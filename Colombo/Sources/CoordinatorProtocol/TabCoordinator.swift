import Foundation

/// A coordinator that coordinates tabs in a tab view.
@Observable
open class TabCoordinator: PresentableCoordinator {
  #warning("Change into an ordered set.")
  var tabs: [ObjectIdentifier]

  #warning("Fix selection when building with Xcode 15.")
  public var selection: ObjectIdentifier?

  public init() {
    self.tabs = []
    self.selection = nil
  }

  public func register<C, R>(_ tab: C) where R: Router, C: FlowCoordinator<R> {
    guard CoordinatorStorage.shared.coordinators[tab.id] == nil else {
      return
    }

    CoordinatorStorage.shared.add(tab)

    tabs.append(C.id)
    
    if selection == nil {
      select(C.self)
    }
  }

  public func select<C, R>(_ tab: C.Type) where R: Router, C: FlowCoordinator<R> {
    guard tabs.contains(where: { $0 == tab.id }) else {
      fatalError("Attempted to select an unregistered tab.")
    }
    
    selection = tab.id
  }
}
