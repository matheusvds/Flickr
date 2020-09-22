import Foundation

public protocol HttpClient {
    typealias Result = Swift.Result<Data?, HttpError>
    
    @discardableResult
    func send(from request: URLRequest, completion: @escaping (Result) -> Void) -> URLSessionDataTask?
}
