import Foundation
import Domain
import UI
import UIKit

public protocol PhotoListFactoryRepresentable {
    func makePhotoListViewController() -> UIViewController
}

public final class PhotoListFactory: PhotoListFactoryRepresentable {
    
    private let getPhotos: GetPhotos
    private let getSuggestions: GetSuggestions
    private let setSuggestions: SetSuggestions

    public init(getPhotos: GetPhotos, getSuggestions: GetSuggestions, setSuggestions: SetSuggestions) {
        self.getPhotos = getPhotos
        self.getSuggestions = getSuggestions
        self.setSuggestions = setSuggestions
    }
    
    public func makePhotoListViewController() -> UIViewController {
        let presenter = PhotoListPresenter()
        let interactor = PhotoListInteractor(getPhotos: getPhotos, getSuggestions: getSuggestions, setSuggestions: setSuggestions)
        let view = PhotoListView()
        let imageLoder = ImageLoader()
        let viewController = PhotoListViewController(viewLogic: view, interactor: interactor, imageLoader: imageLoder)
        
        view.delegate = viewController
        presenter.displayLogic = viewController
        interactor.presenter = presenter
        
        return viewController
    }
}
