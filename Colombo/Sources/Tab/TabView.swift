import SwiftUI

@MainActor
public extension TabView {
  #if swift(>=6)
  @available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
  init<C, TabCoordinator, Router>(
    coordinator: TabCoordinator.Type,
    @TabContentBuilder<SelectionValue> tab: @escaping (SelectionValue) -> C
  ) where Router: Colombo.Router, TabCoordinator: Colombo.TabCoordinator<Router>, SelectionValue == TabCoordinator.Selection, C: View, Content == ForEach<[SelectionValue], SelectionValue.ID, C> {
    @Coordinator(TabCoordinator.self) var tabCoordinator
    @Bindable var coordinator = tabCoordinator

    self.init(selection: $coordinator.selection) {
      ForEach(coordinator.tabs) { route in
        tab(route)
      }
    }
  }
  #endif

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
