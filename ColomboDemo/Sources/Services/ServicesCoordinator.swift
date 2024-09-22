import Colombo
import Foundation
import SwiftUI

@Observable
final class ServicesCoordinator: FlowCoordinator {
  let root = ServicesHome.id

  var path = NavigationPath()

  var presentation: Presentation? = nil

  var router: some Router {
    ServicesRouter()
  }
}
