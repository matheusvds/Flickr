import Foundation

class RequestObserver {
    static var emit: ((URLRequest) -> Void)?
    static func observe(completion: @escaping (URLRequest) -> Void) {
        RequestObserver.emit = completion
    }
}
