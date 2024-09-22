import Foundation
import SwiftUI

/// A protocol that defines requirements for an object that coordinates navigation.
public protocol Coordinator: Observable, AnyObject, Identifiable {
  associatedtype Destination: View

  typealias Route = Screen.ID

  /// The root of the navigation.
  var root: Route { get }

  /// The path of the navigation stack. Use this property as a binding for the `NavigationStack`.
  var path: NavigationPath { get set }

  /// The presentation on top of the current navigation flow.
  var presentation: Presentation? { get set }

  func push(_ route: Route)

  func pop()

  func popToRoot()

  func present(_ coordinator: any Coordinator, presentationStyle: Presentation.Style)

  func dismiss()

  @ViewBuilder
  func destination(for route: Route) -> Destination
}

public extension Coordinator {
  var id: Route {
    root
  }

  var _presentation: Binding<Presentation?> {
    Binding(
      get: { [presentation] in
        presentation
      },
      set: { [weak self] in
        self?.presentation = $0
      }
    )
  }

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

  /// Presents a new coordinator on top of the current navigation flow.
  /// - Parameters:
  ///   - coordinator: The coordinator to present modally.
  ///   - presentationStyle: The style of the modal presentation.
  func present(_ coordinator: any Coordinator, presentationStyle: Presentation.Style) {
    presentation = Presentation(style: presentationStyle, coordinator: coordinator)
  }

  /// Dismisses any coordinators presented on top of the current navigation flow.
  func dismiss() {
    presentation = nil
  }
}
