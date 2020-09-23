import Foundation

public struct SizesResult: Model {
    public let sizes: Sizes
    
    public struct Sizes: Model {
        public let size: [Size]
    }
    
    public struct Size: Model {
        public let label: String
        public let source: String
    }
}

