import Foundation
import Domain

protocol PhotoListBusinessLogic {
    func fetchPhotos(request: PhotoList.GetPhotos.Request)
    func setSuggestion(request: PhotoList.SetSuggestions.Request)
    func fetchSuggestions(request: PhotoList.GetSuggestions.Request)
}

protocol PhotoListDataStore {
}

class PhotoListInteractor: PhotoListDataStore {
    var presenter: PhotoListPresentationLogic?
    
    // MARK: - Use Cases
    let getPhotosUseCase: GetPhotos
    let getSuggestionsUseCase: GetSuggestions
    let setSuggestionsUseCase: SetSuggestions
    
    init(getPhotos: GetPhotos, getSuggestions: GetSuggestions, setSuggestions: SetSuggestions) {
        self.getPhotosUseCase = getPhotos
        self.getSuggestionsUseCase = getSuggestions
        self.setSuggestionsUseCase = setSuggestions
    }
}

// MARK: - UnlockBusinessLogic
extension PhotoListInteractor: PhotoListBusinessLogic {
    func setSuggestion(request: PhotoList.SetSuggestions.Request) {
        setSuggestionsUseCase.set(suggestion: request.query)
    }
    
    func fetchPhotos(request: PhotoList.GetPhotos.Request) {
        getPhotosUseCase.getPhotos(getPhotosModel: GetPhotosModel(page: request.page, query: request.query)) { [weak self] (result) in
            switch result {
            case .success(let photoRefs):
                self?.presenter?.presentFetchedPhotos(response: PhotoList.GetPhotos.Response(refs: photoRefs))
            case .failure:
                self?.presenter?.presentFetchedPhotos(response: PhotoList.GetPhotos.Response(refs: nil))
            }
        }
    }
    
    func fetchSuggestions(request: PhotoList.GetSuggestions.Request) {
        let suggestions = getSuggestionsUseCase.getSuggestions()
        presenter?.presentFetchedSuggestions(response: PhotoList.GetSuggestions.Response(suggestions: suggestions))
    }
}
