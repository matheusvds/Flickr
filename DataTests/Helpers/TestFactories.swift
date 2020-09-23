import Foundation
import Domain

func makeDummyURL() -> URL {
    return URL(string: "https://anyurl.com")!
}

func makeDummyRequest() -> URLRequest {
    return URLRequest(url: makeDummyURL())
}

func makeValidData() -> Data {
    return Data("{\"property\":\"value\"}".utf8)
}

func makeEmptyData() -> Data {
    return Data()
}

func makeSerchPhotosModel() -> SearchPhotosModel {
    return SearchPhotosModel(page: 0, query: "")
}

func makeSearchResult() -> SearchResult {
    let result: SearchResult? = searchResultJSON.data(using: .utf8)?.toModel()
    return result!
}

func makeHttpResponse(statusCode code: Int = 200) -> HTTPURLResponse {
    return HTTPURLResponse(url: makeDummyURL(), statusCode: code, httpVersion: nil, headerFields: nil)!
}

func makeInvalidData() -> Data {
    return Data("invalid data".utf8)
}

func makeError() -> Error {
    return NSError(domain: "any", code: 0)
}

struct DummyDecodable: Codable, Equatable {
    let property: String
}
