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
        let viewModel = PhotoList.SearchPhotos.ViewModel(items: response.refs?.map{ DisplayedPhoto(image: $0) })
        DispatchQueue.main.async { [weak self] in
            self?.displayLogic?.displaySearchPhotos(viewModel: viewModel)
        }
    }
}
