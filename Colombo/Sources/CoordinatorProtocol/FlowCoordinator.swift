import SwiftUI

/// A protocol that defines requirements for an object that coordinates flow navigation.
public protocol FlowCoordinator: PresentableCoordinator {
  associatedtype FlowRouter: Router

  typealias Route = Screen.ID

  /// The root of the navigation.
  var root: Route { get }

  /// The path of the navigation stack. Use this property as a binding for the `NavigationStack`.
  var path: NavigationPath { get set }

  var router: FlowRouter { get }

  func push(_ route: Route)

  func pop()

  func popToRoot()
}

public extension FlowCoordinator {
  /// Pushes the specified route into the `NavigationStack`.
  func push(_ route: Route) {
    path.append(route)
  }

  /// Pops the last route off the `NavigationStack`.
  func pop() {
    path.removeLast()
  }

  /// Pops to the root of the `NavigationStack`.
  func popToRoot() {
    path.removeLast(path.count)
  }
}
