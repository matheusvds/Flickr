import Foundation
import Domain
import UI
import Application
import UIKit

public protocol Application {
    func start()
}

public class Main: Application {
    
    public var window: UIWindow?
    
    private let photoListScene: PhotoListFactoryRepresentable

    public init(photoListScene: PhotoListFactoryRepresentable) {
        self.photoListScene = photoListScene
    }
    
    public func start() {
        let vc = photoListScene.makePhotoListViewController()
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigation = UINavigationController(rootViewController: vc)
        window.rootViewController = navigation
        self.window = window
        
        window.makeKeyAndVisible()
    }

}
