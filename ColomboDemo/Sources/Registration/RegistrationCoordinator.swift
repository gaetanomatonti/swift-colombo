import Colombo
import Foundation
import SwiftUI

@Observable
final class RegistrationCoordinator: FlowCoordinator<RegistrationRouter> {
  init() {
    super.init(root: .entry, router: RegistrationRouter())
  }
}
