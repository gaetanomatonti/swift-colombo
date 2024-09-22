import Colombo
import Foundation
import SwiftUI

@Observable
final class MenuCoordinator: FlowCoordinator {
  let root = MenuHome.id

  var path = NavigationPath()

  var presentation: Presentation? = nil

  var router: some Router {
    MenuRouter()
  }
}
