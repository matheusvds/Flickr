import Domain
import Foundation

public final class RemoteGetPhotos: GetPhotos {
    private let searchPhotos: SearchPhotos
    private let getSizes: GetSizes
    
    public init(searchPhotos: SearchPhotos, getSizes: GetSizes) {
        self.searchPhotos = searchPhotos
        self.getSizes = getSizes
    }
    
    public func getPhotos(getPhotosModel: GetPhotosModel, completion: @escaping (GetPhotos.Result) -> Void) {
        let dispatchGroup = DispatchGroup()
        var imageReferences = [String?]()
        
        let searchModel = SearchPhotosModel(page: getPhotosModel.page, query: getPhotosModel.query)
        dispatchGroup.enter()
        searchPhotos.searchPhotos(searchPhotosModel: searchModel) { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let searchResult):
                searchResult.photos.photo.compactMap{ $0 }.forEach { (reference) in
                    dispatchGroup.enter()
                    self.getLinks(for: reference.id) { (link) in
                        imageReferences.append(link)
                        dispatchGroup.leave()
                    }
                }
            case .failure:
                completion(.failure(.unexpected))
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            let links = imageReferences.compactMap { $0 }
            if links.isEmpty {
                return completion(.failure(.unexpected))
            }
            completion(.success(links))
        }
    }
    
    private func getLinks(for photoID: String, completion: @escaping (String?) -> Void) {
        getSizes.getSizes(getSizesModel: GetSizesModel(photoID: photoID)) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let sizeResult):
                let link = sizeResult.sizes.size.filter{ $0.label.contains("Large Square") }.first?.source
                completion(link)
            case .failure:
                completion(nil)
            }
        }
    }
}
