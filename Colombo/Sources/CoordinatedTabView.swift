import SwiftUI

/// A view that coordinates a tab.
///
/// The content of this view must be managed by a ``NavigationCoordinator``.
public struct CoordinatedTabView<CoordinatedView, NavigationCoordinator, Router>: View where CoordinatedView: View, Router: Colombo.Router, NavigationCoordinator: Colombo.NavigationCoordinator<Router> {

  // MARK: - Stored Properties

  /// The coordinated view content.
  let coordinatedView: CoordinatedView

  // MARK: - Init

  /// Creates an instance of a coordinated tab view.
  /// - Parameters:
  ///   - coordinator: The type of the coordinator that manages the coordinated view content.
  ///   - content: The content of the coordinated view.
  /// - Note: To work properly, the content of the coordinated view should always return the argument of the content closure.
  ///
  /// ```swift
  /// CoordinatedTabView(ContentCoordinator.self) { coordinatedContent in
  ///   coordinatedContent // CoordinatedNavigationView<ContentCoordinator, ContentCoordinator.Router>
  ///     .tabItem { ... }
  /// }
  /// ```
  public init(
    _ coordinator: NavigationCoordinator.Type,
    @ViewBuilder content: (CoordinatedNavigationView<NavigationCoordinator, Router>) -> CoordinatedView
  ) {
    self.coordinatedView = content(CoordinatedNavigationView())
  }
  
  // MARK: - Body

  public var body: some View {
    @Coordinator(NavigationCoordinator.self) var coordinator

    coordinatedView
      .tag(NavigationCoordinator.id)
      .environment(\.presentationCoordinator, coordinator)
  }
}
