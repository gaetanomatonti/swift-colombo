import Colombo
import Foundation
import SwiftUI

@Observable
final class ServicesCoordinator: FlowCoordinator {
  let root = ServicesRoute.home

  var path = NavigationPath()

  var presentation: Presentation? = nil

  let router = ServicesRouter()
}
