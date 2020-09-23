import Foundation

protocol PhotoListPresentationLogic {
    func presentSearchPhotos(response: PhotoList.SearchPhotos.Response)
}

class PhotoListPresenter {
    weak var displayLogic: PhotoListDisplayLogic?
}

// MARK: - PhotoListPresentationLogic
extension PhotoListPresenter: PhotoListPresentationLogic {
    func presentSearchPhotos(response: PhotoList.SearchPhotos.Response) {

    }
}
