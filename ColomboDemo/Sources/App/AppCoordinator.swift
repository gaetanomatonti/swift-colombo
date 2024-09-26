import Colombo
import Foundation

@Observable
final class AppCoordinator: TabCoordinator<TabRouter> {
  convenience init() {
    self.init(router: TabRouter())
  }
}
