import Foundation

public protocol FlickrAPIRequest {
    var resource: FlickrResource { get }
    var method: String { get }
}

public extension FlickrAPIRequest {
    var scheme: String {
        return "https"
    }
    
    var baseURL: String {
        return "api.flickr.com"
    }
    
    var path: String {
        return "/services/rest/"
    }
    
    var serviceURL: URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = baseURL
        components.path = path
        components.queryItems = queryItems
        return components.url!
    }
    
    var request: URLRequest {
        var request = URLRequest(url: serviceURL)
        request.httpMethod = method
        return request
    }
    
    var method: String {
        return "GET"
    }
    
    var queryItems: [URLQueryItem] {
        var queries = [URLQueryItem]()
        queries.append(contentsOf: resource.query)
        queries.append(contentsOf: [
            URLQueryItem(name: "api_key", value: "f9cc014fa76b098f9e82f1c288379ea1"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "nojsoncallback", value: "1")
        ])
            
        return queries
    }
}
