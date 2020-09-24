import Foundation

public protocol GetImageData {
    func loadImage(_ url: URL?, _ completion: @escaping (Result<Data?, Error>) -> Void) -> UUID?
    func cancelLoad(_ uuid: String)
}
