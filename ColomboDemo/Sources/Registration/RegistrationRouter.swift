import Colombo
import Foundation
import SwiftUI

struct RegistrationRouter: Router {
  func destination(for route: RegistrationRoute) -> some View {
    switch route {
    case .entry:
      RegistrationEntry()

    case .personalData:
      RegistrationPersonalData()
    }
  }
}
