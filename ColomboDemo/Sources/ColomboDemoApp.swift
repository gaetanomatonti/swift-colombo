import Colombo
import SwiftUI

@main
struct ColomboDemoApp: App {
  @State private var servicesCoordinator = ServicesCoordinator()
  @State private var menuCoordinator = MenuCoordinator()

  var body: some Scene {
    WindowGroup {
      TabView {
        CoordinatedView(coordinator: $servicesCoordinator)
          .tabItem {
            Label("Services", systemImage: "mappin.and.ellipse")
          }
          .environment(servicesCoordinator)

        CoordinatedView(coordinator: $menuCoordinator)
          .tabItem {
            Label("Menu", systemImage: "line.3.horizontal")
          }
          .environment(menuCoordinator)
      }
    }
  }
}
