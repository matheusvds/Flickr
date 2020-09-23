import Foundation
import XCTest
import Infra
import Data

class URLSessionAdapterTests: XCTestCase {
    func test_get_should_have_request_with_valid_url() {
        let dummyRequest = makeDummyRequest()
        testRequest(for: dummyRequest) { request in
            XCTAssertEqual(dummyRequest.url, request.url)
        }
    }
    
    func test_get_should_complete_with_error_when_request_completes_with_error() {
        expect(result: .failure(.noConnection), when: (data: nil, response: nil, error: makeError()))
    }
    
    func test_get_should_complete_with_error_on_all_invalid_cases() {
        expect(result: .failure(.noConnection), when: (data: makeValidData(), response: makeHttpResponse(), error: makeError()))
        expect(result: .failure(.noConnection), when: (data: makeValidData(), response: nil, error: makeError()))
        expect(result: .failure(.noConnection), when: (data: makeValidData(), response: nil, error: nil))
        expect(result: .failure(.noConnection), when: (data: nil, response: makeHttpResponse(), error: makeError()))
        expect(result: .failure(.noConnection), when: (data: nil, response: nil, error: nil))
    }
    
    func test_get_should_complete_with_data_when_request_completes_with_200() {
        let data = makeValidData()
        expect(result: .success(data), when: (data: data, response: makeHttpResponse(), error: nil))
    }
    
    func test_get_should_complete_with_error_when_request_not_completes_with_200() {
        expect(result: .failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 400), error: nil))
        expect(result: .failure(.serverError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 500), error: nil))
        expect(result: .failure(.unauthorized), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 401), error: nil))
        expect(result: .failure(.forbidden), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 403), error: nil))
        expect(result: .failure(.noConnection), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 300), error: nil))
    }
    
    func test_get_should_complete_with_no_data_when_request_completes_with_204() {
        expect(result: .success(nil), when: (data: makeEmptyData(), response: makeHttpResponse(statusCode: 204), error: nil))
        expect(result: .success(nil), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 204), error: nil))
    }
}

extension URLSessionAdapterTests {
    func makeSut(file: StaticString = #file, line: UInt = #line) -> URLSessionAdapter {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sut = URLSessionAdapter(session: session)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut

    }
    
    func testRequest(for request: URLRequest = makeDummyRequest(), action: @escaping (URLRequest)-> Void) {
        let sut = makeSut()
        let exp = expectation(description: "wait")
        sut.send(from: request) { _ in exp.fulfill() }
        var request: URLRequest?
        RequestObserver.observe { request = $0 }
        wait(for: [exp], timeout: 1.0)
        action(request!)
    }
    
    func expect(result expectedResult: Result<Data?, HttpError>, when stub: (data: Data?, response: HTTPURLResponse?, error: Error?), file: StaticString = #file, line: UInt = #line) {
        let sut = makeSut()
        URLProtocolStub.simulate(data: stub.data, response: stub.response, error: stub.error)
        let exp = expectation(description: "wait")
        sut.send(from: makeDummyRequest()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedData), .success(let receivedData)):
                XCTAssertEqual(expectedData, receivedData, file: file, line: line)
            default: XCTFail("expecting \(expectedResult) got \(receivedResult)", file: file, line: line)
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
}
