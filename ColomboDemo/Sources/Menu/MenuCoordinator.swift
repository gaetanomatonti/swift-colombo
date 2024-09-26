import Colombo
import Foundation
import SwiftUI

@Observable
final class MenuCoordinator: NavigationCoordinator<MenuRouter> {
  init() {
    super.init(root: .home, router: MenuRouter())
  }
}
