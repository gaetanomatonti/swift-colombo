import SwiftUI

@MainActor
public protocol NavigationCoordinatorProtocol: CoordinatorProtocol {
  associatedtype Route: Colombo.Route
  
  var root: Route { get }
  
  var path: Stack<Route> { get }
}

/// A protocol that defines requirements for an object that coordinates flow navigation.
@Observable
open class NavigationCoordinator<Router>: PresentationCoordinator, NavigationCoordinatorProtocol where Router: Colombo.Router {
  public typealias Route = Router.Route
  
  // MARK: - Stored Properties
  
  /// The path of the navigation stack. Use this property as a binding for the `NavigationStack`.
  internal(set) public var path: Stack<Route> {
    didSet {
      print(path)
    }
  }

  /// The root of the navigation.
  private(set) public var root: Route

  /// The router that defines the destinations of the navigation.
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
