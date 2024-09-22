import SwiftUI

public struct CoordinatedTabView<C, L>: View where C: Coordinator, L: View {
  let coordinator: C

  let tabLabel: L

  public init(coordinator: C, @ViewBuilder tabLabel: () -> L) where L == Label<Text, Image> {
    self.coordinator = coordinator
    self.tabLabel = tabLabel()
  }

  public var body: some View {
    CoordinatedView(coordinator: coordinator)
      .tabItem {
        tabLabel
      }
      .tag(coordinator.id)
  }
}
