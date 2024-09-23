import SwiftUI

/// A view that coordinates a tab.
///
/// The content of this view must be managed by a ``FlowCoordinator``.
public struct CoordinatedTabView<C, L, R>: View where R: Router, C: NavigationCoordinator<R>, L: View {
  
  // MARK: - Stored Properties
  
  /// The label of the tab item.
  let tabLabel: L

  // MARK: - Init
  
  public init(_ coordinator: C.Type, @ViewBuilder tabLabel: () -> L) where L == Label<Text, Image> {
    self.tabLabel = tabLabel()
  }
  
  // MARK: - Body

  public var body: some View {
    CoordinatedNavigationView<C, R>()
      .tabItem {
        tabLabel
      }
      .tag(C.id)
  }
}
