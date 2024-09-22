import Colombo
import SwiftUI

struct ServicesHome: View, Screen {
  @Environment(ServicesCoordinator.self) var coordinator

  var body: some View {
    Button("Registration") {
      coordinator.present(RegistrationCoordinator(), presentationStyle: .fullScreenCover)
    }
  }
}

@Observable
final class ServicesCoordinator: FlowCoordinator {
  let root = ServicesHome.id

  var path = NavigationPath()

  var presentation: Presentation? = nil
  
  func destination(for route: Route) -> some View {
    switch route {
    case ServicesHome.id:
      ServicesHome()

    default:
      EmptyView()
    }
  }
}
