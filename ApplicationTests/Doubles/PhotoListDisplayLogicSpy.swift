import Foundation

@testable import Application

class PhotoListDisplayLogicSpy: PhotoListDisplayLogic {
    var displayFetchedPhotosCalled = false
    var fetchPhotosViewModel: PhotoList.GetPhotos.ViewModel?
    
    func displayFetchedPhotos(viewModel: PhotoList.GetPhotos.ViewModel) {
        displayFetchedPhotosCalled = true
        fetchPhotosViewModel = viewModel
    }
}
