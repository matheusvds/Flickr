import Foundation
import Domain

public class RemoteGetImageData: GetImageData {
    private var loadedImages = [URL: Data]()
    private var runningRequests = [UUID: URLSessionDataTask]()
    private let client: HttpClient
    
    public init(client: HttpClient) {
        self.client = client
    }
    
    public func loadImage(_ url: URL?, _ completion: @escaping (Result<Data, Error>) -> Void) -> UUID? {
        guard let url = url else { return nil }
        
        if let image = loadedImages[url] {
            completion(.success(image))
            return nil
        }
        
        let uuid = UUID()
        let task = client.send(from: URLRequest(url: url)) { (result) in
            defer { self.runningRequests.removeValue(forKey: uuid) }

            switch result {
            case .success(let data):
                if let data = data {
                    self.loadedImages[url] = data
                    return completion(.success(data))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        runningRequests[uuid] = task!
        return uuid
    }
}
