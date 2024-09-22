import Colombo
import SwiftUI

struct RegistrationEntry: View, Screen {
  @Environment(RegistrationCoordinator.self) var coordinator

  @Environment(\.dismiss) var dismiss

  var body: some View {
    VStack(spacing: 32) {
      Text("Entry")

      Button("Next") {
        coordinator.push(RegistrationPersonalData.id)
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

struct RegistrationPersonalData: View, Screen {
  var body: some View {
    Text("Personal Data")
  }
}

@Observable
final class RegistrationCoordinator: Coordinator {
  let root = RegistrationEntry.id

  var path = NavigationPath()

  var presentation: Presentation? = nil

  func destination(for route: Route) -> some View {
    switch route {
    case RegistrationEntry.id:
      RegistrationEntry()

    case RegistrationPersonalData.id:
      RegistrationPersonalData()

    default:
      EmptyView()
    }
  }
}
