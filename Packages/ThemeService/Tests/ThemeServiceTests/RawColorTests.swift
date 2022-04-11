//
//  RawColorTests.swift
//
//  Created by Bradley Mackey on 08/04/2022.
//

import XCTest
@testable import ThemeService

final class RawColorTests: XCTestCase {
    func test_parseHexInt_zero() throws {
        let color = RawColor(hex: 0x000000)
        XCTAssertEqual(color?.red, 0)
        XCTAssertEqual(color?.green, 0)
        XCTAssertEqual(color?.blue, 0)
        XCTAssertEqual(color?.opacity, 1)
    }
    
    func test_parseHexInt_max() throws {
        let color = RawColor(hex: 0xffffff)
        XCTAssertEqual(color?.red, 1)
        XCTAssertEqual(color?.green, 1)
        XCTAssertEqual(color?.blue, 1)
        XCTAssertEqual(color?.opacity, 1)
    }
    
    func test_parseHexInt_overflow() throws {
        let color = RawColor(hex: 0x1000000)
        XCTAssertNil(color)
    }
    
    func test_parseHexInt_exact() throws {
        let color = RawColor(hex: 0xeeeeee)
        XCTAssertEqual(color?.red, 0.93333333)
        XCTAssertEqual(color?.green, 0.93333333)
        XCTAssertEqual(color?.blue, 0.93333333)
        XCTAssertEqual(color?.opacity, 1)
    }
    
    func test_parseHexInt_ordering() throws {
        let color = RawColor(hex: 0xffee00)
        XCTAssertEqual(color?.red, 1)
        XCTAssertEqual(color?.green, 0.93333333)
        XCTAssertEqual(color?.blue, 0)
        XCTAssertEqual(color?.opacity, 1)
    }
    
    func test_parseHexString_zero() throws {
        let color = RawColor(hex: "#000000")
        XCTAssertEqual(color?.red, 0)
        XCTAssertEqual(color?.green, 0)
        XCTAssertEqual(color?.blue, 0)
        XCTAssertEqual(color?.opacity, 1)
    }
    
    func test_parseHexString_max() throws {
        let color = RawColor(hex: "#ffffff")
        XCTAssertEqual(color?.red, 1)
        XCTAssertEqual(color?.green, 1)
        XCTAssertEqual(color?.blue, 1)
        XCTAssertEqual(color?.opacity, 1)
    }
    
    func test_parseHexString_ordering() throws {
        let color = RawColor(hex: "#ffee00")
        XCTAssertEqual(color?.red, 1)
        XCTAssertEqual(color?.green, 0.93333333)
        XCTAssertEqual(color?.blue, 0)
        XCTAssertEqual(color?.opacity, 1)
    }
    
    func test_parseHexString_overflow() throws {
        let color = RawColor(hex: "#1000000")
        XCTAssertNil(color)
    }
    
    func test_parseHexString_underflow() throws {
        let color = RawColor(hex: "#-1")
        XCTAssertNil(color)
    }
    
    func test_parseHexString_noLeadingPound() throws {
        let color = RawColor(hex: "FFFFFF")
        XCTAssertNil(color)
    }
    
    func test_parseHexString_invalidHex() throws {
        let color = RawColor(hex: "#gggggg")
        XCTAssertNil(color)
    }
    
    func test_parseHexString_alternatingCase() throws {
        let color = RawColor(hex: "#fFFfff")
        XCTAssertEqual(color?.red, 1)
        XCTAssertEqual(color?.green, 1)
        XCTAssertEqual(color?.blue, 1)
        XCTAssertEqual(color?.opacity, 1)
    }
}
