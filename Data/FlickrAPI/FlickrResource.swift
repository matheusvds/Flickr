import Foundation

public enum FlickrResource {
    case search(query: String, page: Int)
    case getSizes(photoID: String)
    
    var query: [URLQueryItem] {
        switch self {
        case .search(let query, let page):
            return makeSearchQueries(query: query, page: page)
        case .getSizes(let photoID):
            return makeGetSizesQueries(photoID: photoID)
        }
    }
    
    private func makeSearchQueries(query: String, page: Int) -> [URLQueryItem] {
        return [
            URLQueryItem(name: "method", value: "flickr.photos.search"),
            URLQueryItem(name: "tags", value: query),
            URLQueryItem(name: "page", value: "\(page)"),
        ]
    }
    
    private func makeGetSizesQueries(photoID: String) -> [URLQueryItem] {
        return [
            URLQueryItem(name: "method", value: "flickr.photos.getSizes"),
            URLQueryItem(name: "photo_id", value: photoID)
        ]
    }
}
