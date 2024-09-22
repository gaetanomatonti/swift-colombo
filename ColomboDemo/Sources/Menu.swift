import Colombo
import SwiftUI

struct MenuHome: View, Screen {
  @Environment(MenuCoordinator.self) var coordinator

  @Environment(AppCoordinator.self) var appCoordinator

  var body: some View {
    List {
      Button("Registration") {
        coordinator.present(RegistrationCoordinator(), presentationStyle: .sheet)
      }

      Button("Support") {
        coordinator.push(MenuSupport.id)
      }

      Button("Services") {
        appCoordinator.select(ServicesCoordinator.self)
      }
    }
  }
}

struct MenuSupport: View, Screen {
  var body: some View {
    Text("Support")
  }
}

@Observable
final class MenuCoordinator: FlowCoordinator {
  let root = MenuHome.id

  var path = NavigationPath()

  var presentation: Presentation? = nil

  func destination(for route: Route) -> some View {
    switch route {
    case MenuHome.id:
      MenuHome()

    case MenuSupport.id:
      MenuSupport()

    default:
      EmptyView()
    }
  }
}
