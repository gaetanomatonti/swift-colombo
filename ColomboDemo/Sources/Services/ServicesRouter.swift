import Colombo
import SwiftUI

struct ServicesRouter: Router {  
  func destination(for route: _Screen.ID) -> some View {
    switch route {
    case ServicesHome.id:
      ServicesHome()

    default:
      EmptyView()
    }
  }
}
