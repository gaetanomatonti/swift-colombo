import SwiftUI

public struct CoordinatedTabView<C, L>: View where C: FlowCoordinator, L: View {
  let tabLabel: L

  public init(_ coordinator: C.Type, @ViewBuilder tabLabel: () -> L) where L == Label<Text, Image> {
    self.tabLabel = tabLabel()
  }

  public var body: some View {
    CoordinatedView<C>()
      .tabItem {
        tabLabel
      }
      .tag(C.id)
  }
}
