import XCTest
@testable import Data

class RemoteSearchPhotosTests: XCTestCase {
    
    func test_search_should_complete_with_error() {
        let (sut, spy) = makeSut()
    }

}


extension RemoteSearchPhotosTests {
    func makeSut() -> (RemoteSearchPhotos, HttpClientSpy) {
        let clientSpy = HttpClientSpy()
        let sut = RemoteSearchPhotos(httpClient: clientSpy)
        checkMemoryLeak(for: clientSpy)
        checkMemoryLeak(for: sut)
        return (sut, clientSpy)
    }
}
