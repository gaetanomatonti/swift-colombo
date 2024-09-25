import Colombo
import SwiftUI

@main
struct ColomboDemoApp: App {
  @RootCoordinator private var coordinator = AppCoordinator()
  
  @Coordinator private var servicesCoordinator = ServicesCoordinator()

  @Coordinator private var menuCoordinator = MenuCoordinator()

  var body: some Scene {
    WindowGroup {
      TabView(AppCoordinator.self)
    }
  }
}
