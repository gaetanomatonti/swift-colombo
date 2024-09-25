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

@Observable
final class AppCoordinator: TabCoordinator<TabRouter> {
  convenience init() {
    self.init(router: TabRouter())
  }
}

enum TabRoute: Route, CaseIterable {
  case services
  case menu
}

struct TabRouter: Router {
  @ViewBuilder
  func destination(for route: TabRoute) -> some View {
    switch route {
    case .services:
      NavigationStack(ServicesCoordinator.self)
      
    case .menu:
      NavigationStack(MenuCoordinator.self)
    }
  }
}
