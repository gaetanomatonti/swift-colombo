import Colombo
import Foundation
import SwiftUI

@Observable
final class MenuCoordinator: FlowCoordinator {
  let root = MenuRoute.home

  var path = NavigationPath()

  var presentation: Presentation? = nil

  let router = MenuRouter()
}
