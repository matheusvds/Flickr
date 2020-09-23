import Foundation
import Data

public final class URLSessionAdapter: HttpClient {

    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    @discardableResult
    public func send(from request: URLRequest, completion: @escaping (Result<Data?, HttpError>) -> Void) -> URLSessionDataTask? {
        let task = session.dataTask(with: request) { (data, urlResponse, error) in
            if let data = data, let response = urlResponse as? HTTPURLResponse, error == nil {
                switch response.statusCode {
                case 204:
                    return completion(.success(nil))
                case 200...299:
                    return completion(.success(data))
                case 401:
                    return completion(.failure(.unauthorized))
                case 403:
                    return completion(.failure(.forbidden))
                case 400...499:
                    return completion(.failure(.badRequest))
                case 500...599:
                    return completion(.failure(.serverError))
                default:
                    return completion(.failure(.noConnection))
                }
            } else {
                return completion(.failure(.noConnection))
            }
        }
        task.resume()
        
        return task
    }
}
