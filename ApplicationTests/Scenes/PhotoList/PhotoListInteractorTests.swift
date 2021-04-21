import XCTest
import Domain
@testable import Application

class PhotoListInteractorTests: XCTestCase {

    func test_fetch_photo_should_ask_get_photos_to_fetch() {
        let (sut, getPhotosSpy, _) = makeSut()
        sut.fetchPhotos(request: PhotoList.GetPhotos.Request(query: "kittens", page: 1))
        
        XCTAssert(getPhotosSpy.getPhotosCalled)
    }
    
    func test_fetch_pokemons_should_ask_presenter_to_output_response() {
        let (sut, getPhotosSpy, presenterSpy) = makeSut()
        sut.fetchPhotos(request: PhotoList.GetPhotos.Request(query: "kittens", page: 1))
        getPhotosSpy.complete(withPhotos: ["something"])
        XCTAssert(presenterSpy.presentFetchedPhotosCalled)
    }
    
    func test_fetch_pokemons_should_send_response_with_nil_refs_when_completes_with_error() {
        let (sut, getPhotosSpy, presenterSpy) = makeSut()
        sut.fetchPhotos(request: PhotoList.GetPhotos.Request(query: "kittens", page: 1))
        getPhotosSpy.complete(withError: .unexpected)
        XCTAssertNil(presenterSpy.response?.refs)
    }
    
    func test_fetch_pokemons_should_send_response_with_expected_filled_refs_when_completes_with_success() {
        let (sut, getPhotosSpy, presenterSpy) = makeSut()
        let expectedPhotos = ["something"]
        sut.fetchPhotos(request: PhotoList.GetPhotos.Request(query: "kittens", page: 1))
        getPhotosSpy.complete(withPhotos: expectedPhotos)
        presenterSpy.response?.refs?.enumerated().forEach({ (refItem) in
            XCTAssertEqual(refItem.element, expectedPhotos[refItem.offset])
        })
    }
}

extension PhotoListInteractorTests {
    func makeSut() -> (PhotoListInteractor, GetPhotosSpy, PhotoListPresentationLogicSpy) {
        let getPhotosSpy = GetPhotosSpy()
        let presenterSpy = PhotoListPresentationLogicSpy()
        let getSuggestionSpy = GetSuggestionsSpy()
        let setSuggestionSpy = SetSuggestionsSpy()
        let sut = PhotoListInteractor(getPhotos: getPhotosSpy, getSuggestions: getSuggestionSpy, setSuggestions: setSuggestionSpy)
        sut.presenter = presenterSpy
        return (sut, getPhotosSpy, presenterSpy)
    }
}

final class GetSuggestionsSpy: GetSuggestions {
    func getSuggestions() -> [String] { return [] }
}

final class SetSuggestionsSpy: SetSuggestions {
    func set(suggestions: [String]) {}
}
