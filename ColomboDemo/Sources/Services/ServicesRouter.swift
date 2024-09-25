import Colombo
import SwiftUI

struct ServicesRouter: Router {  
  func destination(for route: ServicesRoute) -> some View {
    switch route {
    case .home:
      ServicesHome()
        .presentationDestination(RegistrationCoordinator.self)
    }
  }
}
