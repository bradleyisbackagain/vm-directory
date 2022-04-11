//
//  DirectoryAPITests.swift
//
//  Created by Bradley Mackey on 08/04/2022.
//

import XCTest
@testable import DirectoryService

class DirectoryAPITests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func test_stubDirectoryProducesItems() {
        let stub = StubDirectoryAPI(peopleData: .success([]), roomsData: .success([]))
        
        let expected = expectation(description: "load items")
        stub.people { result in
            switch result {
            case .success(let value):
                XCTAssertEqual(value, [])
            case .failure(let error):
                XCTFail("Did not expect error \(error)")
            }
            expected.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }

}
