import Foundation

/// Identifiable gives a class a reuseIdentifier based on the Type's name
public protocol Identifiable: class {
    static var reuseIdentifier: String { get }
}

public extension Identifiable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
