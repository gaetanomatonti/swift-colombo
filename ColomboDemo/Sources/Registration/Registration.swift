import Colombo
import SwiftUI

struct RegistrationEntry: View {
  @Environment(RegistrationCoordinator.self) var coordinator

  @Environment(\.dismiss) var dismiss

  var body: some View {
    VStack(spacing: 32) {
      Text("Entry")

      Button("Next") {
        coordinator.push(.personalData)
      }
    }
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        Button("Close", systemImage: "xmark") {
          dismiss()
        }
        .bold()
      }
    }
  }
}

struct RegistrationPersonalData: View {
  var body: some View {
    Text("Personal Data")
  }
}
