import Foundation
import UIKit

@testable import Application

class UIImageLoaderDummy: UIImageLoader {
    func load(_ url: String, for imageView: UIImageView, at row: Int) {
        
    }
    
    func cancel(for imageView: UIImageView) {
        
    }
}
