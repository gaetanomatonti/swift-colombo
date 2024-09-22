import SwiftUI

extension View {
  @ViewBuilder
  func presentation(item: Binding<Presentation?>) -> some View {
    self
      .sheet(item: item.sheet) { item in
        AnyCoordinatedView(coordinator: .constant(item.coordinator))
      }
      .fullScreenCover(item: item.fullScreenCover) { item in
        AnyCoordinatedView(coordinator: .constant(item.coordinator))
      }
  }
}
