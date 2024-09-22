import Colombo
import Foundation
import SwiftUI

@Observable
final class ServicesCoordinator: FlowCoordinator<ServicesRouter> {
  init() {
    super.init(root: .home, router: ServicesRouter())
  }
}
