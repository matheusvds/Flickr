import Foundation
import Domain
import UI

typealias DisplayedPhoto = PhotoList.SearchPhotos.ViewModel.DisplayedPhoto

enum PhotoList {
    enum SearchPhotos {
        
        struct Request {

        }
        
        struct Response {

        }
        
        struct ViewModel: PhotoListViewModel {
            var items: [PhotoListItem]
                        
            struct DisplayedPhoto: PhotoListItem {
                let image: String
            }
        }
    }
}
