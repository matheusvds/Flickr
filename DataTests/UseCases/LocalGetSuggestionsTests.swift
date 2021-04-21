import Foundation
import XCTest
import Domain
import Data

class LocalGetSuggestionsTests: XCTestCase {
    
    func test_sut_should_complete_with_success_when_user_settings_completes_with_valid_data() {
        let (sut, spy) = makeSut()
        let expectedResult = makeGetSuggestions()
        spy.completeWith(data: expectedResult.toData())
        
        let result = sut.getSuggestions()
        XCTAssertEqual(expectedResult, result)
    }
    
    func test_sut_should_complete_with_success_when_user_settings_completes_with_incorrect_data() {
        let (sut, spy) = makeSut()
        spy.completeWith(data: makeValidData())
        
        let result = sut.getSuggestions()
        XCTAssert(result.isEmpty)
    }
    
    func test_sut_should_complete_with_success_when_user_settings_completes_with_invalid_data() {
        let (sut, spy) = makeSut()
        spy.completeWith(data: makeInvalidData())
        
        let result = sut.getSuggestions()
        XCTAssert(result.isEmpty)
    }
    
    func test_sut_should_complete_with_empty_array_when_user_settings_completes_with_nil_data() {
        let (sut, spy) = makeSut()
        spy.completeWithNilData()
        
        let result = sut.getSuggestions()
        XCTAssert(result.isEmpty)
    }
}

extension LocalGetSuggestionsTests {
    
    func makeSut() -> (LocalGetSuggestions, UserSettingsSpy) {
        let spy = UserSettingsSpy()
        let sut = LocalGetSuggestions(userSettings: spy)
        
        return (sut, spy)
    }
}

