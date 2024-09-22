import Colombo
import SwiftUI

@main
struct ColomboDemoApp: App {
  @State private var coordinator = AppCoordinator()

  var body: some Scene {
    WindowGroup {
      TabView(selection: $coordinator.selection) {
        CoordinatedTabView(coordinator: coordinator.servicesCoordinator) {
          Label("Services", systemImage: "mappin.and.ellipse")
        }
        .presentationDestination(RegistrationCoordinator.self, over: $coordinator.servicesCoordinator)

        CoordinatedTabView(coordinator: coordinator.menuCoordinator) {
          Label("Menu", systemImage: "line.3.horizontal")
        }
        .presentationDestination(RegistrationCoordinator.self, over: $coordinator.menuCoordinator)
      }
      .environment(coordinator)
    }
  }
}

@Observable
final class AppCoordinator {
  var selection: ObjectIdentifier?

  var tabs: [ObjectIdentifier] = []

  var servicesCoordinator = ServicesCoordinator()

  var menuCoordinator = MenuCoordinator()

  func select<C>(tab: C.Type) where C: Coordinator {
    selection = tab.id
  }
}
