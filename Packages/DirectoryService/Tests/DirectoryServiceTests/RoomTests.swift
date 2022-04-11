//
//  RoomTests.swift
//
//  Created by Bradley Mackey on 11/04/2022.
//

import XCTest
import CommonUtils
@testable import DirectoryService

class RoomTests: XCTestCase {
    
    var decoder: JSONDecoder!

    override func setUpWithError() throws {
        decoder = JSONDecoder()
        let dateDecoder = ISO8601MillisecondsDecoder()
        decoder.dateDecodingStrategy = .custom(dateDecoder.decode)
    }

    override func tearDownWithError() throws {
    }
    
    func test_decodesFromJSON() throws {
        let string = """
        {
        "createdAt": "2022-01-24T17:02:23.729Z",
        "isOccupied": false,
        "maxOccupancy": 53539,
        "id": "1"
        }
        """
        let data = string.data(using: .utf8)!
        
        let decoded = try decoder.decode(Room.self, from: data)
        
        XCTAssertEqual(decoded.isOccupied, false)
        XCTAssertEqual(decoded.maxOccupancy, 53539)
        XCTAssertEqual(decoded.id, "1")
        
        let expectedDate = Date(timeIntervalSince1970: 1643043743.729)
        XCTAssertEqual(decoded.createdAt, expectedDate)
    }

}
