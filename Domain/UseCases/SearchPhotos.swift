import Foundation

public protocol SearchPhotos {
    typealias Result = Swift.Result<SearchResult, DomainError>
    func searchPhotos(searchPhotosModel: SearchPhotosModel, completion: @escaping (Result) -> Void)
}

public struct SearchPhotosModel {
    public var page: Int
    public var word: String
    
    public init(page: Int, word: String) {
        self.page = page
        self.word = word
    }
}
