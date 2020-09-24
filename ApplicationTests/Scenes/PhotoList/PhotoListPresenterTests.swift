import Foundation
import XCTest

@testable import Application

class PhotoListPresenterTests: XCTestCase {
    func test_present_fetched_photos_should_ask_display_logic_to_output_viewmodel() {
        let (sut, displayLogicSpy) = makeSut()
        sut.presentFetchedPhotos(response: PhotoList.GetPhotos.Response(refs: ["Something"]))
        XCTAssert(displayLogicSpy.displayFetchedPhotosCalled)
    }
    
    func test_present_fetched_photos_should_display_formatted_viewmodel() {
        let (sut, displayLogicSpy) = makeSut()
        sut.presentFetchedPhotos(response: PhotoList.GetPhotos.Response(refs: ["Something"]))
        displayLogicSpy.fetchPhotosViewModel?.items?.forEach({ (item) in
            XCTAssertEqual(item.image, "Something")
        })
    }
}

extension PhotoListPresenterTests {
    func makeSut() -> (PhotoListPresenter, PhotoListDisplayLogicSpy) {
        let displayLogicSpy = PhotoListDisplayLogicSpy()
        let sut = PhotoListPresenter()
        sut.displayLogic = displayLogicSpy
        return (sut, displayLogicSpy)
    }
}
