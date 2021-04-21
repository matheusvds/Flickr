import Foundation
import Domain
import UIKit
import SDWebImage

protocol UIImageLoader {
    func load(_ url: String, for imageView: UIImageView, at row: Int)
}

class ImageLoader: UIImageLoader {
    func load(_ url: String, for imageView: UIImageView, at row: Int) {
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.sd_setImage(with: URL(string: url))
    }
}
