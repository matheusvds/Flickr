import Foundation

public protocol GetPhotos {
    typealias Result = Swift.Result<[String], DomainError>
    func getPhotos(getPhotosModel: GetPhotosModel, completion: @escaping (Result) -> Void)
}

public struct GetPhotosModel {
    public var page: Int
    public var query: String
    
    public init(page: Int, query: String) {
        self.page = page
        self.query = query
    }
}
