import Foundation

struct ImageSizesRequest {
    let photoID: String
    
    init(photoID: String) {
        self.photoID = photoID
    }
}

extension ImageSizesRequest: FlickrAPIRequest {
    var resource: FlickrResource {
        .getSizes(photoID: photoID)
    }
}
