//
//  ISO8601MillisecondsDecoderTests.swift
//
//  Created by Bradley Mackey on 11/04/2022.
//

import XCTest
@testable import CommonUtils

class ISO8601MillisecondsDecoderTests: XCTestCase {
    
    private struct DemoContainer: Decodable {
        var d: Date
    }
    
    var decoder: JSONDecoder!
   
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        decoder = JSONDecoder()
        let dateDecoder = ISO8601MillisecondsDecoder()
        decoder.dateDecodingStrategy = .custom(dateDecoder.decode)
    }
    
    func test_decodeWithMilliseconds() throws {
        let string = #"{"d":"2022-01-24T17:02:23.729Z"}"#
        let data = string.data(using: .utf8)!
        let decoded = try decoder.decode(DemoContainer.self, from: data)
        
        let expected = Date(timeIntervalSince1970: 1643043743.729)
        XCTAssertEqual(expected, decoded.d)
    }
    
    func test_cannotDecodeWithoutMilliseconds() throws {
        let string = #"{"d":"2022-01-24T17:02:23Z"}"#
        let data = string.data(using: .utf8)!
        XCTAssertThrowsError(try decoder.decode(DemoContainer.self, from: data))
    }
}
