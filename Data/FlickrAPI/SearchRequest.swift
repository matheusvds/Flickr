import Foundation

struct SearchRequest {
    let query: String
    let page: Int
    
    init(query: String, page: Int) {
        self.query = query
        self.page = page
    }
}

extension SearchRequest: FlickrAPIRequest {
    var resource: FlickrResource {
        .search(query: query, page: page)
    }
}
