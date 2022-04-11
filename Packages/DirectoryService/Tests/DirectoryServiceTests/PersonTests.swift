//
//  PersonTests.swift
//
//  Created by Bradley Mackey on 11/04/2022.
//

import XCTest
import CommonUtils
@testable import DirectoryService

class PersonTests: XCTestCase {
    
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
          "firstName": "Maggie",
          "avatar": "https://randomuser.me/api/portraits/women/21.jpg",
          "lastName": "Brekke",
          "email": "Crystel.Nicolas61@hotmail.com",
          "jobtitle": "Future Functionality Strategist",
          "favouriteColor": "pink",
          "id": "1"
        }
        """
        let data = string.data(using: .utf8)!
        
        let decoded = try decoder.decode(Person.self, from: data)
        
        XCTAssertEqual(decoded.firstName, "Maggie")
        XCTAssertEqual(decoded.lastName, "Brekke")
        XCTAssertEqual(decoded.email, "Crystel.Nicolas61@hotmail.com")
        XCTAssertEqual(decoded.jobTitle, "Future Functionality Strategist")
        XCTAssertEqual(decoded.favouriteColor, "pink")
        XCTAssertEqual(decoded.id, "1")
        XCTAssertEqual(decoded.avatar.absoluteString, "https://randomuser.me/api/portraits/women/21.jpg")
        
        let expectedDate = Date(timeIntervalSince1970: 1643043743.729)
        XCTAssertEqual(decoded.createdAt, expectedDate)
    }

}
