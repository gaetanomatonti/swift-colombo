import Colombo
import Foundation
import SwiftUI

@Observable
final class MenuCoordinator: FlowCoordinator<MenuRouter> {
  init() {
    super.init(root: .home, router: MenuRouter())
  }
}
