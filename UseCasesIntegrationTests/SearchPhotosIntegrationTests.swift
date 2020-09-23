import XCTest
import Data
import Domain
import Infra

class UseCasesIntegrationTests: XCTestCase {

        func test_search_images() {
        let urlSessionAdapter = URLSessionAdapter()
        let sut: SearchPhotos = RemoteSearchPhotos(httpClient: urlSessionAdapter)
        
        let exp = expectation(description: "wait")
            sut.searchPhotos(searchPhotosModel: SearchPhotosModel(page: 1, query: "kitten")) { (result) in
            switch result {
            case .success(let searchResult):
                XCTAssertFalse(searchResult.photos.photo.isEmpty)
                
            case .failure: XCTFail("expecting success, got \(result)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 2.0)
    }
}
