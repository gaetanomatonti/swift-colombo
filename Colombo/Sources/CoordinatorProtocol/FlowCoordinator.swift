import SwiftUI

/// A protocol that defines requirements for an object that coordinates flow navigation.
public protocol FlowCoordinator: PresentableCoordinator {
  associatedtype Destination: View

  typealias Route = Screen.ID

  /// The root of the navigation.
  var root: Route { get }

  /// The path of the navigation stack. Use this property as a binding for the `NavigationStack`.
  var path: NavigationPath { get set }

  func push(_ route: Route)

  func pop()

  func popToRoot()

  #warning("Move the logic of this function inside CoordinatedView, or in a Router protocol. This way we can make the Coordinator protocol a class and have more control over the implementation of the methods.")
  @ViewBuilder
  func destination(for route: Route) -> Destination
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

/*
 protocol Router {
   associatedtype Destination: View

   associatedtype Route: Hashable

   @ViewBuilder
   func destination(for route: Route) -> Destination
 }
 */
