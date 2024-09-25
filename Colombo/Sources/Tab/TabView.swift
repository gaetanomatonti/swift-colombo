import SwiftUI

@MainActor
public extension TabView {
  init<TabCoordinator, Router>(
    _ coordinator: TabCoordinator.Type
  ) where Router: Colombo.Router, TabCoordinator: Colombo.TabCoordinator<Router>, SelectionValue == TabCoordinator.Selection, Content == CoordinatedTabViewContent<Router, TabCoordinator> {
    @Coordinator(TabCoordinator.self) var tabCoordinator
    @Bindable var coordinator = tabCoordinator

    self.init(selection: $coordinator.selection) {
      CoordinatedTabViewContent<Router, TabCoordinator>()      
    }
  }
}
