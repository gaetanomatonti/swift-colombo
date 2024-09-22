import Foundation
import SwiftUI
import UIKit

public protocol Route: Hashable {}

// Route macro
/*
 @Routable("contentView")
 struct ContentView: View {
    ...
 }

 @Routable
 ...
 extension Routes {
    // How do i pass dependencies to a screen? (e.g.: an item to display)
   static let contentView = Screen.ID(...)
 }
 ...


 coordinator.push(.contentView)

 coordinator.present(.contentView, presentationStyle: ...)
*/
