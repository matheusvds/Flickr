import Foundation
import XCTest
import Domain

@testable import Application

class PhotoListViewControllerTests: XCTestCase {

    var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    func loadView(_ sut: PhotoListViewController) {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    func test_should_fetch_photos_when_view_loads() {
        let (sut, _, businessSpy) = makeSut()
        loadView(sut)
        sut.viewDidLoad()
        
        XCTAssert(businessSpy.fetchPhotosCalled)
    }
    
    func test_display_fetched_photos_ask_view_logic_to_set_viewmodel() {
        let (sut, viewLogicSpy, _) = makeSut()
        sut.displayFetchedPhotos(viewModel: PhotoList.GetPhotos.ViewModel(items: [DisplayedPhoto(image: "image")]))
        
        XCTAssert(viewLogicSpy.setViewModelCalled)
    }
    
    func test_display_fetched_photos_should_output_expected_viewmodel() {
        let (sut, viewLogicSpy, _) = makeSut()
        let expected = [DisplayedPhoto(image: "image")]
        sut.displayFetchedPhotos(viewModel: PhotoList.GetPhotos.ViewModel(items: expected))
        
        viewLogicSpy.viewModel?.items?.enumerated().forEach({ (item) in
            XCTAssertEqual(item.element.image, expected[item.offset].image)
        })
    }
}

extension PhotoListViewControllerTests {
    func makeSut() -> (PhotoListViewController, PhotoListViewLogicSpy, PhotoListBusinessLogicSpy)  {
        let viewLogicSpy = PhotoListViewLogicSpy()
        let businessLogicSpy = PhotoListBusinessLogicSpy()
        let sut = PhotoListViewController(viewLogic: viewLogicSpy, interactor: businessLogicSpy, imageLoader: UIImageLoaderDummy())
        return (sut, viewLogicSpy, businessLogicSpy)
    }
}
