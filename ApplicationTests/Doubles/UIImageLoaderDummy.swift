import Foundation
import UIKit

@testable import Application

class UIImageLoaderDummy: UIImageLoader {
    func load(_ url: String, for imageView: UIImageView) {}
    
    func cancel(for imageView: UIImageView) {}
}
