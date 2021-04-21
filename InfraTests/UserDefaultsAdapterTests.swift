import Foundation
import XCTest
import Data
import Infra

class UserDefaultsAdapterTests: XCTestCase {
    
    func test_sut_should_complete_with_data_when_defaults_completes_with_valid_data() {
        let (sut, spy) = makeSut()
        let expectedResult = makeGetSuggestions()
        spy.setValue(expectedResult.toData(), forKey: "suggestions")
        
        let result = sut.get(setting: "suggestions")
        XCTAssertNotNil(result)
    }
}

extension UserDefaultsAdapterTests {
    
    func makeSut() -> (UserDefaultsAdapter, UserDefaultsSpy) {
        let spy = UserDefaultsSpy()
        let sut = UserDefaultsAdapter(userDefaults: spy)
        
        return (sut, spy)
    }
    
}
