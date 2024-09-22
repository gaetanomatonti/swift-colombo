import SwiftUI

/// A protocol that defines requirements for an object that coordinates flow navigation.
@Observable
open class FlowCoordinator<R>: PresentableCoordinator where R: Router {

  public typealias Route = R._Route

  /// The root of the navigation.
  private(set) public var root: Route

  /// The path of the navigation stack. Use this property as a binding for the `NavigationStack`.
  internal(set) public var path: NavigationPath

  private(set) public var router: R

  // MARK: - Init

  public init(root: Route, path: NavigationPath = NavigationPath(), router: R) {
    self.root = root
    self.path = path
    self.router = router
  }

  // MARK: - Functions

  /// Pushes the specified route into the `NavigationStack`.
  public func push(_ route: Route) {
    path.append(route)
  }

  /// Pops the last route off the `NavigationStack`.
  public func pop() {
    path.removeLast()
  }

  /// Pops to the root of the `NavigationStack`.
  public func popToRoot() {
    path.removeLast(path.count)
  }
}
