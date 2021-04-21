import Foundation

@testable import Application

class PhotoListBusinessLogicSpy: PhotoListBusinessLogic {
    
    var fetchPhotosCalled = false
    
    func fetchPhotos(request: PhotoList.GetPhotos.Request) {
        fetchPhotosCalled = true
    }
    
    func fetchSuggestions(request: PhotoList.GetSuggestions.Request) {}
}
