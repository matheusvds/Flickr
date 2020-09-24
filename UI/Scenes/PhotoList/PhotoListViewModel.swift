import Foundation

public protocol PhotoListViewModel {
    var items: [PhotoListItem]? { get }
}

public protocol PhotoListItem {
    var image: String { get }
}

struct PhotoListVM: PhotoListViewModel {
    let items: [PhotoListItem]?
    
    init(items: [PhotoListItem]) {
        self.items = items
    }
}

struct PhotoListItemVM: PhotoListItem {
    let image: String
    
    init(image: String) {
        self.image = image
    }
}
