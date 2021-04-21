import Foundation
import Domain

protocol PhotoListBusinessLogic {
    func fetchPhotos(request: PhotoList.GetPhotos.Request)
    func fetchSuggestions(request: PhotoList.GetSuggestions.Request)
}

protocol PhotoListDataStore {
}

class PhotoListInteractor: PhotoListDataStore {
    var presenter: PhotoListPresentationLogic?
    
    // MARK: - Use Cases
    let getPhotos: GetPhotos
    let getSuggestions: GetSuggestions
    let setSuggestions: SetSuggestions
    
    init(getPhotos: GetPhotos, getSuggestions: GetSuggestions, setSuggestions: SetSuggestions) {
        self.getPhotos = getPhotos
        self.getSuggestions = getSuggestions
        self.setSuggestions = setSuggestions
    }
}

// MARK: - UnlockBusinessLogic
extension PhotoListInteractor: PhotoListBusinessLogic {
    func fetchPhotos(request: PhotoList.GetPhotos.Request) {
        setSuggestions(with: request.query)
        getPhotos.getPhotos(getPhotosModel: GetPhotosModel(page: request.page, query: request.query)) { [weak self] (result) in
            switch result {
            case .success(let photoRefs):
                self?.presenter?.presentFetchedPhotos(response: PhotoList.GetPhotos.Response(refs: photoRefs))
            case .failure:
                self?.presenter?.presentFetchedPhotos(response: PhotoList.GetPhotos.Response(refs: nil))
            }
        }
    }
    
    func fetchSuggestions(request: PhotoList.GetSuggestions.Request) {
        let suggestions = getSuggestions.getSuggestions()
        presenter?.presentFetchedSuggestions(response: PhotoList.GetSuggestions.Response(suggestions: suggestions))
    }

    private func setSuggestions(with query: String) {
        if query.isEmpty { return }
        var currentSuggestions = getSuggestions.getSuggestions()
        currentSuggestions.append(query)
        setSuggestions.set(suggestions: currentSuggestions)
    }
}
