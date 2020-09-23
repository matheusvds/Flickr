import XCTest
import Domain
@testable import Data

class RemoteSearchPhotosTests: XCTestCase {
    
    func test_search_should_not_complete_when_sut_is_deallocated() {
        let httpClientSpy = HttpClientSpy()
        var sut: RemoteSearchPhotos? = RemoteSearchPhotos(httpClient: httpClientSpy)
        var receivedResult: Result<SearchResult, DomainError>?
        
        sut?.searchPhotos(searchPhotosModel: makeSerchPhotosModel()) { receivedResult = $0 }
        sut = nil
        
        httpClientSpy.complete(withError: .badRequest)
        
        XCTAssertNil(receivedResult)
        
    }
    
    func test_search_should_complete_with_success_when_client_completes_with_valid_data() {
        let (sut, httpClientSpy) = makeSut()
        let expectedResult = makeSearchResult()
        expect(sut, completeWith: .success(expectedResult), when: {
            httpClientSpy.complete(withData: expectedResult.toData()!)
        })
    }
    
    func test_search_should_complete_with_error_when_client_completes_with_invalid_format_data() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.complete(withData: makeInvalidData())
        })
    }
    
    func test_search_should_complete_with_error_when_client_completes_with_not_decodable_valid_data() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.complete(withData: makeValidData())
        })
    }
    
    func test_search_should_complete_with_error_when_client_completes_with_unexpected_error() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.complete(withError: .badRequest)
        })
    }

    func test_search_should_complete_with_error_when_client_completes_with_forbidden_error() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.complete(withError: .forbidden)
        })
    }
    
    func test_search_should_complete_with_error_when_client_completes_with_no_connection_error() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.complete(withError: .noConnection)
        })
    }
    
    func test_search_should_complete_with_error_when_client_completes_with_server_error() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.complete(withError: .serverError)
        })
    }
    
    func test_search_should_complete_with_error_when_client_completes_with_unauthorized_error() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.complete(withError: .unauthorized)
        })
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
    
    func expect(_ sut: RemoteSearchPhotos, completeWith expectedResult: Result<SearchResult, DomainError>, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let expect = expectation(description: "wait")
        sut.searchPhotos(searchPhotosModel: makeSerchPhotosModel()) { receivedResult in
            switch (expectedResult, receivedResult) {
            
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedPokemonList), .success(let receivedPokemonList)):
                XCTAssertEqual(expectedPokemonList, receivedPokemonList, file: file, line: line)

            default: XCTFail("expecting \(expectedResult), got \(receivedResult)", file: file, line: line)
            }
            expect.fulfill()
        }
        action()
        wait(for: [expect], timeout: 1.0)
    }
}
