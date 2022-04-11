//
//  URLExtensionTests.swift
//
//  Created by Bradley Mackey on 09/04/2022.
//

import XCTest
@testable import CommonUtils

final class URLExtensionTests: XCTestCase {
    func test_createValidStaticURL() throws {
        let url = URL("https://google.com/images")
        XCTAssertEqual(url.host, "google.com")
        XCTAssertEqual(url.path, "/images")
    }
    func test_createValidStaticFileURL() throws {
        let url = URL("file:///var/private")
        XCTAssertEqual(url.host, nil)
        XCTAssertEqual(url.path, "/var/private")
    }
}
