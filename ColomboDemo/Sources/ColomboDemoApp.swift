import Colombo
import SwiftUI

@main
struct ColomboDemoApp: App {
  @Coordinator private var coordinator = AppCoordinator()

  init() {
    coordinator.register(ServicesCoordinator())
    coordinator.register(MenuCoordinator())
  }

  var body: some Scene {
    @Bindable var coordinator = coordinator
    
    WindowGroup {
      TabView(selection: $coordinator.selection) {
        CoordinatedTabView(ServicesCoordinator.self) {
          Label("Services", systemImage: "mappin.and.ellipse")
        }
        .presentationDestination(RegistrationCoordinator.self, over: ServicesCoordinator.self)

        CoordinatedTabView(MenuCoordinator.self) {
          Label("Menu", systemImage: "line.3.horizontal")
        }
        .presentationDestination(RegistrationCoordinator.self, over: MenuCoordinator.self)
      }
      .environment(coordinator)
    }
  }
}

@Observable
final class AppCoordinator: TabCoordinator {}
