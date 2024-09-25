import Foundation

/// A coordinator that coordinates tabs in a tab view.
@Observable
open class TabCoordinator<Router>: PresentationCoordinator where Router: Colombo.Router {
  
  public typealias Selection = Router.Route
  
  // MARK: - Stored Properties

  /// The identifier of the selected coordinator.
  #warning("Fix selection when building with Xcode 15.")
  internal(set) public var selection: Selection

  private(set) public var router: Router

  /// The coordinator set as tabs.
  #warning("Change into an ordered set.")
  private(set) public var tabs: [Selection]

  // MARK: - Init
  
  public init(router: Router, tabs: [Selection]) {
    assert(!tabs.isEmpty, "TabCoordinator requires at least one tab.")
    
    self.router = router
    self.tabs = tabs
    self.selection = tabs.first!
  }
  
  public init(router: Router, selection: Selection, tabs: [Selection]) {
    assert(!tabs.isEmpty, "TabCoordinator requires at least one tab.")
    assert(tabs.contains(selection), "Attempted to select a tab that is not registered.")
    
    self.router = router
    self.tabs = tabs
    self.selection = selection
  }
  
  public convenience init(router: Router) where Selection: CaseIterable, Selection.AllCases == [Selection] {
    self.init(router: router, tabs: Selection.allCases)
  }
  
  public convenience init(router: Router, selection: Selection) where Selection: CaseIterable, Selection.AllCases == [Selection] {
    self.init(router: router, selection: selection, tabs: Selection.allCases)
  }
  
  // MARK: - Functions

//  public func register<Coordinator, Router>(_ tab: Coordinator) where Router: Colombo.Router, Coordinator: NavigationCoordinator<Router> {
//    guard CoordinatorStorage.shared.coordinators[tab.id] == nil else {
//      return
//    }
//
//    CoordinatorStorage.shared.add(tab)
//
//    tabs.append(Coordinator.id)
//
//    if selection == nil {
//      select(Coordinator.self)
//    }
//  }

  public func select(_ tab: Selection) {
    guard tabs.contains(tab) else {
      fatalError("Attempted to select an unregistered tab.")
    }
    
    selection = tab
  }
}
