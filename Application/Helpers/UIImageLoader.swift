import Foundation
import Domain
import UIKit

protocol UIImageLoader {
    func load(_ url: String, for imageView: UIImageView)
}

class ImageLoader: UIImageLoader {
    
    private let getImageData: GetImageData
    private var uuidMap = [UIImageView: UUID]()
    
    public init(getImageData: GetImageData) {
        self.getImageData = getImageData
    }
    
    func load(_ url: String, for imageView: UIImageView) {
        
        let token = getImageData.loadImage(URL(string: url)) { result in
            defer { self.uuidMap.removeValue(forKey: imageView) }
            do {
                let data = try result.get()
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: data)
                }
            } catch {
                debugPrint("error downloading image. \(error)")
            }
        }
        
        if let token = token {
            uuidMap[imageView] = token
        }
    }
}
