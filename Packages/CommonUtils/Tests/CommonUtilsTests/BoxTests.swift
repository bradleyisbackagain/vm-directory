//
//  BoxTests.swift
//
//  Created by Bradley Mackey on 10/04/2022.
//

import XCTest
@testable import CommonUtils

final class BoxTests: XCTestCase {
    func test_boxValueEqualsInitial() throws {
        let box = Box("Hello")
        XCTAssertEqual(box.value, "Hello")
    }
    func test_boxBindingCalledOnInitialBindingCreation() throws {
        let box = Box("Hello")
        var currentValue = ""
        box.bind { newValue in
            currentValue = newValue
        }
        XCTAssertEqual(currentValue, "Hello")
    }
    func test_boxBindingUpdatesWithNewValue() throws {
        let box = Box("Hello")
        var currentValue = ""
        box.bind { newValue in
            currentValue = newValue
        }
        box.value = "New Value"
        XCTAssertEqual(currentValue, "New Value")
    }
    func test_boxOnlyHasSingleBinding() throws {
        let box = Box("Hello")
        var value1 = ""
        box.bind { newValue in
            value1 = newValue
        }
        var value2 = ""
        box.bind { newValue in
            value2 = newValue
        }
        box.value = "New Value"
        
        XCTAssertEqual(value1, "Hello")
        XCTAssertEqual(value2, "New Value")
    }
}
