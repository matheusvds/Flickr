import Foundation
import Domain
import UIKit

protocol UIImageLoader {
    func load(_ url: String, for imageView: UIImageView, at row: Int)
    func cancel(for imageView: UIImageView)
}

class ImageLoader: UIImageLoader {
    private let getImageData: GetImageData
    private var uuidMap = NSCache<UIImageView, NSString>()
    
    public init(getImageData: GetImageData) {
        self.getImageData = getImageData
    }
    
    func load(_ url: String, for imageView: UIImageView, at row: Int) {
        let token = getImageData.loadImage(URL(string: url)) { result in
            defer { self.uuidMap.removeObject(forKey: imageView) }
            
            if let data = try? result.get() {
                DispatchQueue.main.async {
                    let data = UIImage(data: data)
                    if imageView.tag == row {
                        imageView.stopLoading()
                        imageView.image = data
                    }
                }
            } else {
                DispatchQueue.main.async {
                    imageView.addLoading()
                    imageView.image = UIImage()
                }
            }
        }
        
        if let token = token {
            uuidMap.setObject(token.uuidString as NSString, forKey: imageView)
        }
    }
    
    func cancel(for imageView: UIImageView) {
        if let uuid = uuidMap.object(forKey: imageView) {
            getImageData.cancelLoad(uuid as String)
            uuidMap.removeObject(forKey: imageView)
            DispatchQueue.main.async {
                imageView.stopLoading()
                imageView.image = nil
            }
        }
    }
}


extension UIImageView {
    static let loadingID = 1234
    func addLoading() {
        let loading = UIActivityIndicatorView(style: .medium)
        loading.tag = Self.loadingID
        loading.startAnimating()
        addSubview(loading)
        loading.snp.makeConstraints { (make) in
            make.centerY.centerX.equalToSuperview()
            make.height.equalTo(loading.snp.width)
            make.width.equalToSuperview().multipliedBy(0.15)
        }
    }
    
    func stopLoading() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}
