import XCTest
@testable import Data

class FlickrAPIRequestTests: XCTestCase {
    
    func test_search_request_should_have_expected_url_formation() {
        let sut = SearchRequest(query: "kitten", page: 1)
        let expectedUrl = "https://api.flickr.com/services/rest/?method=flickr.photos.search&tags=kitten&page=1&api_key=f9cc014fa76b098f9e82f1c288379ea1&format=json&nojsoncallback=1"
        XCTAssertEqual(sut.request.url?.absoluteString, .some(expectedUrl))
    }
    
    func test_image_sizes_request_should_have_expected_url_formation() {
        let sut = ImageSizesRequest(photoID: "1234")
        let expectedUrl  = "https://api.flickr.com/services/rest/?method=flickr.photos.getSizes&photo_id=1234&api_key=f9cc014fa76b098f9e82f1c288379ea1&format=json&nojsoncallback=1"
        XCTAssertEqual(sut.request.url?.absoluteString, .some(expectedUrl))
    }

}
