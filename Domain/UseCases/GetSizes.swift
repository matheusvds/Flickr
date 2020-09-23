import Foundation

public protocol GetSizes {
    typealias Result = Swift.Result<SizesResult, DomainError>
    func getSizes(getSizesModel: GetSizesModel, completion: @escaping (Result) -> Void)
}

public struct GetSizesModel {
    public var photoID: String
    
    public init(photoID: String) {
        self.photoID = photoID
    }
}
