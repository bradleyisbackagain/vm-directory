//
//  ListItemServiceTests.swift
//  DirectoryTests
//
//  Created by Bradley Mackey on 11/04/2022.
//

import XCTest
@testable import Directory
@testable import DirectoryService

class ListItemServiceTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func test_roomsListItemServiceProducesItems() {
        let stub = StubDirectoryAPI(peopleData: .success([]), roomsData: .success([]))
        let service = ListItemViewModelRoomServiceAdapter(api: stub)
        let expected = expectation(description: "load items")
        service.items { result in
            switch result {
            case .success(let value):
                XCTAssertEqual(value.count, 0)
            case .failure(let error):
                XCTFail("Did not expect error \(error)")
            }
            expected.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func test_personListItemServiceProducesItems() {
        let stub = StubDirectoryAPI(peopleData: .success([]), roomsData: .success([]))
        let service = ListItemViewModelPersonServiceAdapter(api: stub)
        let expected = expectation(description: "load items")
        service.items { result in
            switch result {
            case .success(let value):
                XCTAssertEqual(value.count, 0)
            case .failure(let error):
                XCTFail("Did not expect error \(error)")
            }
            expected.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func test_personListItemServiceFallsBackOnError() {
        struct DemoError: Error {}
        let failStub = StubDirectoryAPI(peopleData: .failure(DemoError()), roomsData: .failure(DemoError()))
        let fallbackStub = StubDirectoryAPI(peopleData: .success([]), roomsData: .success([]))
        
        let failService = ListItemViewModelPersonServiceAdapter(api: failStub)
        let fallbackService = ListItemViewModelPersonServiceAdapter(api: fallbackStub)
        
        let service = failService.fallback(fallbackService)
        
        let expected = expectation(description: "load items")
        service.items { result in
            switch result {
            case .success(let value):
                XCTAssertEqual(value.count, 0)
            case .failure(let error):
                XCTFail("Did not expect error \(error)")
            }
            expected.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
}
