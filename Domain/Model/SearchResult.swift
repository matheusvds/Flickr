import Foundation

public struct SearchResult: Model {
    public let photos: Photos
    public let stat: String
    
    public struct Photos: Model {
        public let page: Int
        public let pages: Int
        public let photo: [Reference]
    }
}
