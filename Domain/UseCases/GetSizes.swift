import Foundation

public protocol GetSizes {
    typealias Result = Swift.Result<SearchResult, DomainError>
    func getSizes(getSizesModel: GetSizesModel, completion: @escaping (Result) -> Void)
}

public struct GetSizesModel {
    public var photoID: Int
    
    public init(photoID: Int) {
        self.photoID = photoID
    }
}
