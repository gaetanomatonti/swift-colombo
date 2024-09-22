import Foundation

public protocol Screen {
  typealias ID = _Screen.ID

  var id: ID { get }

  static var id: ID { get }
}

public extension Screen {
  var id: ID {
    ID(String(describing: type(of: self)))
  }

  static var id: ID {
    ID(String(describing: self))
  }
}

public enum _Screen {
  public struct ID: CustomDebugStringConvertible, Hashable, Identifiable {
    let value: String

    public var id: String {
      value
    }

    public var debugDescription: String {
      value
    }

    init(_ value: String) {
      self.value = value
    }
  }
}
