import Colombo
import SwiftUI

@main
struct ColomboDemoApp: App {
  @RootCoordinator private var coordinator = AppCoordinator()

  init() {
    coordinator.register(ServicesCoordinator())
    coordinator.register(MenuCoordinator())
  }

  var body: some Scene {
    @Bindable var coordinator = coordinator
    
    WindowGroup {
      TabView(selection: $coordinator.selection) {
        NavigationStack(ServicesCoordinator.self)
          .presentationDestination(RegistrationCoordinator.self)
          .coordinator(ServicesCoordinator.self)
          .tabItem {
            Label("Services", systemImage: "mappin.and.ellipse")
          }
          .tag(ServicesCoordinator.id)

        NavigationStack(MenuCoordinator.self)
          .presentationDestination(RegistrationCoordinator.self)
          .coordinator(MenuCoordinator.self)
          .tabItem {
            Label("Menu", systemImage: "line.3.horizontal")
          }
          .tag(MenuCoordinator.id)
      }
    }
  }
}

@Observable
final class AppCoordinator: TabCoordinator {}

/*
 TabView(AppCoordinator.self)

 init(...) {
   @Coordinator(...) var coordinator
   @Bindable var ...

   self.init(selection: $coordinator.selection) {
     ForEach(coordinator.tabs) { route in
       coordinator.router.destination(for: route)
         .coordinator(coordinator) ?? (Present always on the main app coordinator?)
         .tag(route)
     }
   }
 }
 */
