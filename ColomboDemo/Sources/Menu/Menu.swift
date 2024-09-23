import Colombo
import SwiftUI

struct MenuHome: View {
  @Coordinator(MenuCoordinator.self) var coordinator

  @Coordinator(AppCoordinator.self) var appCoordinator

  var body: some View {
    List {
      Section("Presentation") {
        Button("Registration") {
          coordinator.present(
            RegistrationCoordinator(),
            presentationStyle: .sheet(
              cornerRadius: 32,
              presentationDetents: [.medium, .large],
              dragIndicatorVisibility: .hidden
            )
          )
        }
      }

      Section("Navigation") {
        Button("Support") {
          coordinator.push(.support)
        }
      }

      Section("Tab") {
        Button("Services") {
          appCoordinator.select(ServicesCoordinator.self)
        }
      }
    }
  }
}

struct MenuSupport: View {
  var body: some View {
    Text("Support")
  }
}
