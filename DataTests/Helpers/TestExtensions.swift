import Foundation
import XCTest

extension XCTestCase {
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "memory leak found", file: file, line: line)
        }
    }
}

extension Encodable {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
