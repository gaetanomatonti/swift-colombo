import Colombo
import Foundation
import SwiftUI

struct MenuRouter: Router {
  func destination(for route: MenuRoute) -> some View {
    switch route {
    case .home:
      MenuHome()
        .presentationDestination(RegistrationCoordinator.self)

    case .support:
      MenuSupport()
        .presentationDestination(RegistrationCoordinator.self)

    case let .profile(username):
      MenuProfile(username: username)
    }
  }
}
