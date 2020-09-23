import XCTest
import Data
import Domain
import Infra

class GetSizesIntegrationTests: XCTestCase {

        func test_get_sizes() {
        let urlSessionAdapter = URLSessionAdapter()
        let sut: GetSizes = RemoteGetSizes(httpClient: urlSessionAdapter)
        
        let exp = expectation(description: "wait")
            sut.getSizes(getSizesModel: GetSizesModel(photoID: "31456463045")) { (result) in
            switch result {
            case .success(let sizesResult):
                XCTAssertFalse(sizesResult.sizes.size.isEmpty)
                
            case .failure: XCTFail("expecting success, got \(result)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 2.0)
    }
}
