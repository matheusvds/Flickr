import Domain
import Foundation

public final class RemoteSearchPhotos: SearchPhotos {
    private let httpClient: HttpClient
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    public func searchPhotos(searchPhotosModel: SearchPhotosModel, completion: @escaping (SearchPhotos.Result) -> Void) {
        
    }
    
    
}
