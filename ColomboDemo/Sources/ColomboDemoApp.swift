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
        CoordinatedTabView(ServicesCoordinator.self) { view in
          view
            .presentationDestination(RegistrationCoordinator.self)
        }
        .tabItem {
          Label("Services", systemImage: "mappin.and.ellipse")
        }

        CoordinatedTabView(MenuCoordinator.self) { view in
          view
            .presentationDestination(RegistrationCoordinator.self)
        }
        .tabItem {
          Label("Menu", systemImage: "line.3.horizontal")
        }
      }
    }
  }
}

@Observable
final class AppCoordinator: TabCoordinator {}
