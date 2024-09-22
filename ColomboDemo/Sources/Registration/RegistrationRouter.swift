import Colombo
import Foundation
import SwiftUI

struct RegistrationRouter: Router {
  func destination(for route: _Screen.ID) -> some View {
    switch route {
    case RegistrationEntry.id:
      RegistrationEntry()

    case RegistrationPersonalData.id:
      RegistrationPersonalData()

    default:
      EmptyView()
    }
  }
}
