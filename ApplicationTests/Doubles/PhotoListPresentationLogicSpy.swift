import Foundation

@testable import Application

class PhotoListPresentationLogicSpy: PhotoListPresentationLogic {
    var presentFetchedPhotosCalled = false
    var response: PhotoList.GetPhotos.Response?
    func presentFetchedPhotos(response: PhotoList.GetPhotos.Response) {
        presentFetchedPhotosCalled = true
        self.response = response
    }
}
