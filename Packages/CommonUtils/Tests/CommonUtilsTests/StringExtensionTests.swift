//
//  StringExtensionTests.swift
//
//  Created by Bradley Mackey on 10/04/2022.
//

import XCTest
@testable import CommonUtils

final class StringExtensionTests: XCTestCase {
    func test_createStringFromStaticString() throws {
        let staticString: StaticString = #file
        let stringValue = String(staticString)
        XCTAssertEqual(#file, stringValue)
    }
}
