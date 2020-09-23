import Domain
import Foundation

public final class RemoteSearchPhotos: SearchPhotos {
    private let httpClient: HttpClient
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    public func searchPhotos(searchPhotosModel: SearchPhotosModel, completion: @escaping (SearchPhotos.Result) -> Void) {
        let searchRequest = SearchRequest(query: searchPhotosModel.query, page: searchPhotosModel.page)
        httpClient.send(from: searchRequest.request) { [weak self] (result) in
            guard self != nil else { return }
            switch result {
            case .success(let data):
                if let model: SearchResult = data?.toModel() {
                    return completion(.success(model))
                }
                completion(.failure(.unexpected))
            case .failure:
                completion(.failure(.unexpected))
            }
        }
    }
}
