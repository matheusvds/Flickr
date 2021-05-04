import Foundation
import Domain
import UI

typealias DisplayedPhoto = PhotoList.GetPhotos.ViewModel.DisplayedPhoto

enum PhotoList {
    
    enum GetPhotos {
        
        struct Request {
            let query: String
            let page: Int
        }
        
        struct Response {
            let refs: [String]?
        }
        
        struct ViewModel: PhotoListViewModel {
            var items: [PhotoListItem]?
                        
            struct DisplayedPhoto: PhotoListItem {
                let image: String
            }
        }
    }
    
    enum GetSuggestions {
        
        struct Request { }
        struct Response {
            let suggestions: [String]
        }
        struct ViewModel {
            let suggestions: [String]
        }
    }
    
    enum SetSuggestions {
        
        struct Request {
            let query: String
        }
        
        struct Response {}
        struct ViewModel {}
    }
}
