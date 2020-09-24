import Foundation

protocol PhotoListPresentationLogic {
    func presentFetchedPhotos(response: PhotoList.GetPhotos.Response)
}

class PhotoListPresenter {
    weak var displayLogic: PhotoListDisplayLogic?
}

// MARK: - PhotoListPresentationLogic
extension PhotoListPresenter: PhotoListPresentationLogic {
    func presentFetchedPhotos(response: PhotoList.GetPhotos.Response) {
        let viewModel = PhotoList.GetPhotos.ViewModel(items: response.refs?.map{ DisplayedPhoto(image: $0) })
            displayLogic?.displayFetchedPhotos(viewModel: viewModel)
    }
}
