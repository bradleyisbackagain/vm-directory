//
//  RoomListItemTests.swift
//  DirectoryTests
//
//  Created by Bradley Mackey on 11/04/2022.
//

import XCTest
@testable import Directory
@testable import DirectoryService

class RoomListItemTests: XCTestCase {
    
    var occupiedRoom: Room!
    var availableRoom: Room!

    override func setUpWithError() throws {
        occupiedRoom = Room(id: "123", createdAt: Date(), maxOccupancy: 1000, isOccupied: true)
        availableRoom = Room(id: "456", createdAt: Date(), maxOccupancy: 50, isOccupied: false)
    }

    override func tearDownWithError() throws {
    }
}

// MARK: - Labels

extension RoomListItemTests {
    func test_occupiedRoomTitle() {
        let listItem = ListItemViewModel(room: occupiedRoom)
        XCTAssertEqual(listItem.title.value, "Room 123 • Occupied")
    }
    
    func test_availableRoomTitle() {
        let listItem = ListItemViewModel(room: availableRoom)
        XCTAssertEqual(listItem.title.value, "Room 456 • Available")
    }
    
    func test_occupiedRoomSubtitle() {
        let listItem = ListItemViewModel(room: occupiedRoom)
        XCTAssertEqual(listItem.subtitle.value, "1000 seats available")
    }
    
    func test_availableRoomSubtitle() {
        let listItem = ListItemViewModel(room: availableRoom)
        XCTAssertEqual(listItem.subtitle.value, "50 seats available")
    }
}


// MARK: - Query

extension RoomListItemTests {
    
    func test_roomMatchesFullID() {
        let listItem = ListItemViewModel(room: occupiedRoom)
        let match = listItem.matchesQuery("123")
        XCTAssertTrue(match)
    }
    
    func test_roomMatchesPartialID() {
        let listItem = ListItemViewModel(room: occupiedRoom)
        let match = listItem.matchesQuery("12")
        XCTAssertTrue(match)
    }
    
    func test_roomNoMatchesInvalidID() {
        let listItem = ListItemViewModel(room: occupiedRoom)
        let match = listItem.matchesQuery("999")
        XCTAssertFalse(match)
    }
    
    func test_occupiedRoomMatchesOccupiedPartialText() {
        let listItem = ListItemViewModel(room: occupiedRoom)
        let match = listItem.matchesQuery("occu")
        XCTAssertTrue(match)
    }
    
    func test_occupiedRoomMatchesOccupiedFullText() {
        let listItem = ListItemViewModel(room: occupiedRoom)
        let match = listItem.matchesQuery("occupied")
        XCTAssertTrue(match)
    }
    
    func test_occupiedRoomNoMatchesAvailablePartialText() {
        let listItem = ListItemViewModel(room: occupiedRoom)
        let match = listItem.matchesQuery("ava")
        XCTAssertFalse(match)
    }
    
    func test_occupiedRoomNoMatchesAvailableFullText() {
        let listItem = ListItemViewModel(room: occupiedRoom)
        let match = listItem.matchesQuery("available")
        XCTAssertFalse(match)
    }
    
    func test_availableRoomMatchesAvailablePartialText() {
        let listItem = ListItemViewModel(room: availableRoom)
        let match = listItem.matchesQuery("ava")
        XCTAssertTrue(match)
    }
    
    func test_availableRoomMatchesAvailableFullText() {
        let listItem = ListItemViewModel(room: availableRoom)
        let match = listItem.matchesQuery("available")
        XCTAssertTrue(match)
    }
    
    func test_availableRoomNoMatchesOccupiedPartialText() {
        let listItem = ListItemViewModel(room: availableRoom)
        let match = listItem.matchesQuery("occ")
        XCTAssertFalse(match)
    }
    
    func test_availableRoomNoMatchesOccupiedFullText() {
        let listItem = ListItemViewModel(room: availableRoom)
        let match = listItem.matchesQuery("occupied")
        XCTAssertFalse(match)
    }
    
}
