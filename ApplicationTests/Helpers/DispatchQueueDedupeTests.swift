import Foundation
import XCTest

@testable import Application

class DispatchQueueDedupeTests: XCTestCase {
    
    
    func test_deduped_closure_should_be_called_once() {
        let exp = expectation(description: "wait")
        let deduper = DeduperTester(exp: exp)
        (0...20).forEach { (_) in
            deduper.dedupedFunc()
        }
        wait(for: [exp], timeout: 1.0)
        XCTAssert(deduper.array.count == 1)
    }
    

}

class DeduperTester {
    let exp: XCTestExpectation
    var array: [Int] = []
    init(exp: XCTestExpectation) {
        self.exp = exp
    }
    
    func dedupedFunc() {
        DispatchQueue.main.asyncDeduped(target: self, after: 0.3) { [weak self] in
            self?.array.append(3)
            self?.exp.fulfill()
        }
    }
}
