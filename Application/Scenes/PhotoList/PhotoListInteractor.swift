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
    let getPhotos: GetPhotos
    
    init(getPhotos: GetPhotos) {
        self.getPhotos = getPhotos
    }
}

// MARK: - UnlockBusinessLogic
extension PhotoListInteractor: PhotoListBusinessLogic {
    func fetchPhotos(request: PhotoList.SearchPhotos.Request) {
        getPhotos.getPhotos(getPhotosModel: GetPhotosModel(page: request.page, query: request.query)) { [weak self] (result) in
            switch result {
            case .success(let photoRefs):
                self?.presenter?.presentSearchPhotos(response: PhotoList.SearchPhotos.Response(refs: photoRefs))
            case .failure:
                self?.presenter?.presentSearchPhotos(response: PhotoList.SearchPhotos.Response(refs: nil))
            }
        }
    }
}
