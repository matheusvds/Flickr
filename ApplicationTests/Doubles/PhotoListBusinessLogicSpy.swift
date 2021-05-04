import Foundation

@testable import Application

class PhotoListBusinessLogicSpy: PhotoListBusinessLogic {
    
    var fetchPhotosCalled = false
    var setSuggestionCalled = false
    
    func fetchPhotos(request: PhotoList.GetPhotos.Request) {
        fetchPhotosCalled = true
    }
    
    func fetchSuggestions(request: PhotoList.GetSuggestions.Request) {}
    func setSuggestion(request: PhotoList.SetSuggestions.Request) {
        setSuggestionCalled = true
    }
}
