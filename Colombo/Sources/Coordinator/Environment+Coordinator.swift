import SwiftUI

#if swift(>=6)
extension EnvironmentValues {
  /// A reference to the presentation coordinator of the view.
  @Entry var presentationCoordinator: PresentationCoordinator? = nil
}
#else
enum PresentationCoordinatorKey: EnvironmentKey {
  static let defaultValue: PresentationCoordinator? = nil
}

extension EnvironmentValues {
  /// A reference to the presentation coordinator of the view.
  var presentationCoordinator: PresentationCoordinator? {
    get {
      self[PresentationCoordinatorKey.self]
    }
    set {
      self[PresentationCoordinatorKey.self] = newValue
    }
  }
}
#endif
