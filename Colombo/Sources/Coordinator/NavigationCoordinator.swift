import SwiftUI

@MainActor
public protocol NavigationCoordinatorProtocol: CoordinatorProtocol {
  associatedtype Router: Colombo.Router
  
  /// The root of the navigation.
  var root: Router.Route { get }
  
  /// The path of the navigation stack.
  var path: Stack<Router.Route> { get }
  
  /// The router that defines the destinations of the navigation.
  var router: Router { get }
}

extension NavigationCoordinatorProtocol {
  /// Peeks the top element of the `path`.
  func peekRoute() -> Router.Route? {
    path.last
  }
}

/// A protocol that defines requirements for an object that coordinates flow navigation.
@Observable
open class NavigationCoordinator<Router>: PresentationCoordinator, NavigationCoordinatorProtocol where Router: Colombo.Router {
  public typealias Route = Router.Route
  
  // MARK: - Stored Properties
  
  internal(set) public var path: Stack<Route>
  
  private(set) public var root: Route

  private(set) public var router: Router

  // MARK: - Init

  public init(root: Route, path: Stack<Route> = [], router: Router) {
    self.root = root
    self.path = path
    self.router = router
  }

  // MARK: - Functions

  /// Pushes the specified route into the `path`.
  public func push(_ route: Route) {
    path.push(route)
  }

  /// Pops the last route off the `path`.
  public func pop() {
    path.pop()
  }

  /// Pops the last `k` elements of the `path`.
  /// - Parameter k: The number of elements to pop off the stack.
  public func pop(_ k: Int) {
    path.pop(k)
  }

  /// Pops to the root of the `path`.
  public func popToRoot() {
    path.popAll()
  }
}
