import Colombo
import Foundation
import SwiftUI

@Observable
final class RegistrationCoordinator: NavigationCoordinator<RegistrationRouter> {
  init() {
    super.init(root: .entry, router: RegistrationRouter())
  }
}
