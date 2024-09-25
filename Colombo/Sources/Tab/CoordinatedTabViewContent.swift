import SwiftUI

/// A view that can be used as content for a `TabView` whose selection is managed by a ``TabCoordinator``.
///
/// - Note: This type is not meant to be initialized directly. Use `TabView(_ coordinator: TabCoordinator.Type)` instead.
public struct CoordinatedTabViewContent<Router, TabCoordinator>: View where Router: Colombo.Router, TabCoordinator: Colombo.TabCoordinator<Router> {
  
  // MARK: - Computed Properties
  
  /// The coordinator of the view.
  @Coordinator(TabCoordinator.self) var coordinator
  
  // MARK: - Init
  
  init() {}

  public var body: some View {
    ForEach(coordinator.tabs) { tab in
      coordinator.router.destination(for: tab)
        .tag(tab)
    }
  }
}
