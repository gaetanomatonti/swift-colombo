import Foundation

/// A coordinator that coordinates tabs in a tab view.
@Observable
open class TabCoordinator: PresentableCoordinator {
  var tabs: [ObjectIdentifier]

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

    if tabs.isEmpty {
      select(C.self)
    }

    tabs.append(C.id)
  }

  public func select<C, R>(_ tab: C.Type) where R: Router, C: FlowCoordinator<R> {
    selection = tab.id
  }
}
