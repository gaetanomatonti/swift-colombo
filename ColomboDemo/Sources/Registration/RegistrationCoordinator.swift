import Colombo
import Foundation
import SwiftUI

@Observable
final class RegistrationCoordinator: FlowCoordinator {
  let root = RegistrationEntry.id

  var path = NavigationPath()

  var presentation: Presentation? = nil

  var router: some Router {
    RegistrationRouter()
  }
}
