import Foundation
import Domain
import UI
import UIKit

public protocol Application {
    func start()
}

public class Main: Application {
    
    public var window: UIWindow?
    
    private let getImageData: GetImageData
    private let getPhotos: GetPhotos

    public init(getImageData: GetImageData,
                getPhotos: GetPhotos) {
        self.getImageData = getImageData
        self.getPhotos = getPhotos
    }
    
    public func start() {
        let vc = makePhotoListViewController()
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigation = UINavigationController(rootViewController: vc)
        window.rootViewController = navigation
        self.window = window
        
        window.makeKeyAndVisible()
    }
    
    private func makePhotoListViewController() -> PhotoListViewController {
        let presenter = PhotoListPresenter()
        let interactor = PhotoListInteractor(getPhotos: getPhotos)
        let view = PhotoListView()
        let imageLoder = ImageLoader(getImageData: getImageData)
        let viewController = PhotoListViewController(viewLogic: view, interactor: interactor, imageLoader: imageLoder)
        
        view.delegate = viewController
        presenter.displayLogic = viewController
        interactor.presenter = presenter
        
        return viewController
    }
}
