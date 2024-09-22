import Colombo
import Foundation
import SwiftUI

@Observable
final class RegistrationCoordinator: FlowCoordinator {
  let root = RegistrationRoute.entry

  var path = NavigationPath()

  var presentation: Presentation? = nil

  let router = RegistrationRouter()
}
