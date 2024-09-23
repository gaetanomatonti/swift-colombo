import Colombo
import Foundation
import SwiftUI

@Observable
final class ServicesCoordinator: NavigationCoordinator<ServicesRouter> {
  init() {
    super.init(root: .home, router: ServicesRouter())
  }
}
