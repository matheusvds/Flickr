import Domain
import Foundation

public final class RemoteGetSizes: GetSizes {
    private let httpClient: HttpClient
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    public func getSizes(getSizesModel: GetSizesModel, completion: @escaping (GetSizes.Result) -> Void) {
        let getSizesRequest = ImageSizesRequest(photoID: getSizesModel.photoID)
        httpClient.send(from: getSizesRequest.request) { [weak self] (result) in
            guard self != nil else { return }
            switch result {
            case .success(let data):
                if let model: SizesResult = data?.toModel() {
                    return completion(.success(model))
                }
                completion(.failure(.unexpected))
            case .failure:
                completion(.failure(.unexpected))
            }
        }
    }
}
