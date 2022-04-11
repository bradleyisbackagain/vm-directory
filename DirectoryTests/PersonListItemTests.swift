//
//  PersonListItemTests.swift
//  DirectoryTests
//
//  Created by Bradley Mackey on 07/04/2022.
//

import XCTest
@testable import Directory
@testable import DirectoryService

class PersonListItemTests: XCTestCase {
    
    var person: Person!

    override func setUpWithError() throws {
        person = Person(
            id: "123",
            createdAt: Date(timeIntervalSince1970: 0),
            firstName: "Tom",
            lastName: "Jones",
            avatar: URL("https://google.com"),
            email: "xyxxx@place.com",
            jobTitle: "Software Engineer",
            favouriteColor: "Red"
        )
    }

    override func tearDownWithError() throws {
    }
    
    func test_personSearchQueryMatchFirstName() {
        let listItem = ListItemViewModel(person: person, onSelection: {})
        let match = listItem.matchesQuery("Tom")
        XCTAssertTrue(match)
    }
    
    func test_personSearchQueryMatchFirstNameLowercase() {
        let listItem = ListItemViewModel(person: person, onSelection: {})
        let match = listItem.matchesQuery("tom")
        XCTAssertTrue(match)
    }
    
    func test_personSearchQueryMatchLastNameLowercase() {
        let listItem = ListItemViewModel(person: person, onSelection: {})
        let match = listItem.matchesQuery("jones")
        XCTAssertTrue(match)
    }
    
    func test_personSearchQueryMatchEmailPartial() {
        let listItem = ListItemViewModel(person: person, onSelection: {})
        let match = listItem.matchesQuery("xyxxx")
        XCTAssertTrue(match)
    }
    
    func test_personSearchQueryMatchID() {
        let listItem = ListItemViewModel(person: person, onSelection: {})
        let match = listItem.matchesQuery("123")
        XCTAssertTrue(match)
    }
    
    func test_personSearchQueryNotMatchPartialID() {
        let listItem = ListItemViewModel(person: person, onSelection: {})
        let match = listItem.matchesQuery("12")
        XCTAssertFalse(match)
    }
    
    func test_notMatchInvalidQuery() {
        let listItem = ListItemViewModel(person: person, onSelection: {})
        let match = listItem.matchesQuery("sototallynotamatch")
        XCTAssertFalse(match)
    }
}
