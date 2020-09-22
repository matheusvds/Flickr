import Foundation
import Data

class HttpClientSpy: HttpClient {
    
    var requests: [URLRequest] = []
    var completion: ((Result<Data?, HttpError>) -> Void)?
    
    func send(from request: URLRequest, completion: @escaping (Result<Data?, HttpError>) -> Void) -> URLSessionDataTask? {
        self.requests.append(request)
        self.completion = completion
        return nil
    }
    
    func complete(withError error: HttpError) {
        completion?(.failure(error))
    }
    
    func complete(withData data: Data) {
        completion?(.success(data))
    }
    
    func completeWithNilData() {
        completion?(.success(nil))
    }
}
