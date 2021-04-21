import Foundation
import Domain
import UI
import UIKit

public protocol PhotoListFactoryRepresentable {
    func makePhotoListViewController() -> UIViewController
}

public final class PhotoListFactory: PhotoListFactoryRepresentable {
    
    private let getPhotos: GetPhotos

    public init(getPhotos: GetPhotos) {
        self.getPhotos = getPhotos
    }
    
    public func makePhotoListViewController() -> UIViewController {
        let presenter = PhotoListPresenter()
        let interactor = PhotoListInteractor(getPhotos: getPhotos)
        let view = PhotoListView()
        let imageLoder = ImageLoader()
        let viewController = PhotoListViewController(viewLogic: view, interactor: interactor, imageLoader: imageLoder)
        
        view.delegate = viewController
        presenter.displayLogic = viewController
        interactor.presenter = presenter
        
        return viewController
    }
}
