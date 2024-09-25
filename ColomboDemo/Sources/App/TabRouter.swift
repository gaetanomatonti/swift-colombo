import Colombo
import Foundation
import SwiftUI

struct TabRouter: Router {
  @ViewBuilder
  func destination(for route: TabRoute) -> some View {
    switch route {
    case .services:
      NavigationStack(ServicesCoordinator.self)
        .tabItem {
          Label("Services", systemImage: "mappin.and.ellipse")
        }

    case .menu:
      NavigationStack(MenuCoordinator.self)
        .tabItem {
          Label("Menu", systemImage: "line.3.horizontal")
        }
    }
  }
}
