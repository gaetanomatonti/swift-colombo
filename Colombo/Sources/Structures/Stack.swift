import Foundation

/// An ordered collection with stack properties.
public struct Stack<Element> where Element: Hashable {
  public typealias Storage = [Element]
  
  public typealias Element = Storage.Element
  
  public typealias Index = Storage.Index
  
  public typealias SubSequence = Storage.SubSequence
  
  // MARK: - Stored Properties
  
  /// The underlying storage of the stack.
  private(set) var storage: Storage
  
  // MARK: - Functions
  
  /// Pushes the passed element onto the stack.
  public mutating func push(_ element: Element) {
    storage.append(element)
  }
  
  /// Removes the top element off the stack.
  public mutating func pop() {
    storage.removeLast()
  }
  
  /// Removes the specified amount of elements off the stack.
  public mutating func pop(_ count: Int) {
    storage.removeLast(count)
  }
  
  /// Removes all elements from the stack.
  public mutating func popAll() {
    storage.removeAll()
  }
  
  /// Gets the top element of the stack.
  /// - Returns: An optional `Element` on the top of the stack. `nil` if the stack is empty.
  public func peek() -> Element? {
    storage.last
  }
}

extension Stack: MutableCollection {
  public subscript(position: Storage.Index) -> Storage.Element {
    get {
      storage[position]
    }
    set(newValue) {
      storage[position] = newValue
    }
  }
  
  public subscript(bounds: Range<Storage.Index>) -> Storage.SubSequence {
    get {
      storage[bounds]
    }
    set(newValue) {
      storage[bounds] = newValue
    }
  }
}

extension Stack: RandomAccessCollection {
  public var startIndex: Storage.Index {
    storage.startIndex
  }
  
  public var endIndex: Storage.Index {
    storage.endIndex
  }
}

extension Stack: RangeReplaceableCollection {
  public init() {
    self.storage = []
  }

  public mutating func replaceSubrange<C>(_ subrange: Range<Storage.Index>, with newElements: C) where C : Collection, Storage.Element == C.Element {
    storage.replaceSubrange(subrange, with: newElements)
  }
}

extension Stack: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: Element...) {
    self.storage = elements
  }
}

extension Stack: Codable where Element: Codable {}

extension Stack: CustomDebugStringConvertible {
  public var debugDescription: String {
    storage.debugDescription
  }
}
