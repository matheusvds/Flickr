import Foundation
import Domain

protocol PhotoListBusinessLogic {
    func fetchPhotos(request: PhotoList.SearchPhotos.Request)
}

protocol PhotoListDataStore {
}

class PhotoListInteractor: PhotoListDataStore {
    var presenter: PhotoListPresentationLogic?
    
    // MARK: - Use Cases
    let fetchPhotos: SearchPhotos
    
    init(fetchPhotos: SearchPhotos) {
        self.fetchPhotos = fetchPhotos
    }
}

// MARK: - UnlockBusinessLogic
extension PhotoListInteractor: PhotoListBusinessLogic {
    func fetchPhotos(request: PhotoList.SearchPhotos.Request) {

    }
}
