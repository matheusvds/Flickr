import Foundation

public struct SearchResult: Model {
    let photos: Photos
    let stat: String
    
    public struct Photos: Model {
        let page: Int
        let pages: Int
        let photo: [Reference]
    }
}
