import Foundation

public struct SearchResult: Codable {
    let photos: Photos
    let stat: String
    
    public struct Photos: Codable {
        let page: Int
        let pages: Int
        let photo: [Reference]
    }
}
