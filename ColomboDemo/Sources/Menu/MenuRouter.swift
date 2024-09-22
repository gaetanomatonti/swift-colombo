import Colombo
import Foundation
import SwiftUI

struct MenuRouter: Router {
  func destination(for route: _Screen.ID) -> some View {
    switch route {
    case MenuHome.id:
      MenuHome()

    case MenuSupport.id:
      MenuSupport()

    default:
      EmptyView()
    }
  }
}
