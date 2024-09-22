import Colombo
import SwiftUI

struct MenuHome: View {
  @Environment(MenuCoordinator.self) var coordinator

  @Environment(AppCoordinator.self) var appCoordinator

  var body: some View {
    List {
      Button("Registration") {
        coordinator.present(RegistrationCoordinator(), presentationStyle: .sheet)
      }

      Button("Support") {
        coordinator.push(.support)
      }

      Button("Services") {
        appCoordinator.select(ServicesCoordinator.self)
      }
    }
  }
}

struct MenuSupport: View {
  var body: some View {
    Text("Support")
  }
}
