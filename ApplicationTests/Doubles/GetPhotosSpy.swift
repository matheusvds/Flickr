import Foundation
import Domain
@testable import Application

class GetPhotosSpy: GetPhotos {
    var getPhotosCalled = false
    var completion: ((GetPhotos.Result) -> Void)?
    func getPhotos(getPhotosModel: GetPhotosModel, completion: @escaping (GetPhotos.Result) -> Void) {
        getPhotosCalled = true
        self.completion = completion
    }
    
    func complete(withError error: DomainError) {
        self.completion?(.failure(error))
    }

    func complete(withPhotos photos: [String]) {
        self.completion?(.success(photos))
    }
}
