import Foundation
import Domain

public class RemoteGetImageData: GetImageData {
    private var loadedImages = NSCache<NSString, NSData>()
    private var runningRequests = [String: URLSessionDataTask]()
    private let client: HttpClient
    
    public init(client: HttpClient) {
        self.client = client
    }
    
    public func loadImage(_ url: URL?, _ completion: @escaping (Result<Data?, Error>) -> Void) -> UUID? {
        guard let url = url else { return nil }
        
        if let image = loadedImages.object(forKey: url.absoluteString as NSString) {
            completion(.success(image as Data))
            return nil
        } else {
            completion(.success(nil))
        }
        
        let uuid = UUID()
        let task = client.send(from: URLRequest(url: url)) { [weak self] (result) in
            defer { self?.runningRequests.removeValue(forKey: uuid.uuidString) }

            switch result {
            case .success(let data):
                if let data = data {
                    self?.loadedImages.setObject(data as NSData, forKey: url.absoluteString as NSString)
                    return completion(.success(data))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        runningRequests[uuid.uuidString] = task!
        return uuid
    }
    
    public func cancelLoad(_ uuid: String) {
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
}
