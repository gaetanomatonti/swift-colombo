import SwiftUI

public struct CoordinatedTabView<C, L, R>: View where R: Router, C: FlowCoordinator<R>, L: View {
  let tabLabel: L

  public init(_ coordinator: C.Type, @ViewBuilder tabLabel: () -> L) where L == Label<Text, Image> {
    self.tabLabel = tabLabel()
  }

  public var body: some View {
    CoordinatedView<C, R>()
      .tabItem {
        tabLabel
      }
      .tag(C.id)
  }
}
