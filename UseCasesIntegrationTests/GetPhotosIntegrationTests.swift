import XCTest
import Data
import Domain
import Infra

class GetPhotosIntegrationTests: XCTestCase {

        func test_get_photos() {
        let urlSessionAdapter = URLSessionAdapter()
        let searchPhotos = RemoteSearchPhotos(httpClient: urlSessionAdapter)
        let getSizes = RemoteGetSizes(httpClient: urlSessionAdapter)
        let sut = RemoteGetPhotos(searchPhotos: searchPhotos, getSizes: getSizes)
        
        let exp = expectation(description: "wait")
            sut.getPhotos(getPhotosModel: GetPhotosModel(page: 1, query: "kitten")) { (result) in
            switch result {
            case .success(let links):
                XCTAssertFalse(links.isEmpty)
                
            case .failure: XCTFail("expecting success, got \(result)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 2.0)
    }
}
