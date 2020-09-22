import Foundation

public enum HttpError: Error {
    case noConnection
    case badRequest
    case serverError
    case unauthorized
    case forbidden
}
