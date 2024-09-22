import Colombo
import Foundation
import SwiftUI

struct MenuRouter: Router {
  func destination(for route: MenuRoute) -> some View {
    switch route {
    case .home:
      MenuHome()

    case .support:
      MenuSupport()
    }
  }
}
