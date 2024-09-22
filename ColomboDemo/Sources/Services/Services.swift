import Colombo
import SwiftUI

struct ServicesHome: View, Screen {
  @Environment(ServicesCoordinator.self) var coordinator

  var body: some View {
    Button("Registration") {
      coordinator.present(RegistrationCoordinator(), presentationStyle: .fullScreenCover)
    }
  }
}
