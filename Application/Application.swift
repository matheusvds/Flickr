import Foundation
import Data
import UI
import UIKit


public protocol Application {
    func start()
}

public class Main: Application {
    
    public var window: UIWindow?
    
    private let client: HttpClient
    
    public init(client: HttpClient) {
        self.client = client
    }
    
    public func start() {
        let vc = makePhotoListViewController()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = vc
        self.window = window
        
        window.makeKeyAndVisible()
    }
    
    private func makePhotoListViewController() -> PhotoListViewController {
        let presenter = PhotoListPresenter()
        let interactor = PhotoListInteractor(fetchPhotos: RemoteSearchPhotos(httpClient: client))
        let view = PhotoListView()
        let viewController = PhotoListViewController(viewLogic: view, interactor: interactor)
        
        view.delegate = viewController
        presenter.displayLogic = viewController
        interactor.presenter = presenter
        
        return viewController
    }
}
