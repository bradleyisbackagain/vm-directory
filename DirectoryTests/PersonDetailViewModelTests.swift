//
//  PersonDetailTests.swift
//  DirectoryTests
//
//  Created by Bradley Mackey on 11/04/2022.
//

import Foundation
import XCTest
@testable import Directory
@testable import DirectoryService

class PersonDetailViewModelTests: XCTestCase {
    
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
    
    func testFullNameFormatting() {
        let viewModel = PersonDetailViewModel(person)
        XCTAssertEqual(viewModel.fullName, "Tom Jones")
    }
    
    func testAvatarURLIsAvatar() {
        let viewModel = PersonDetailViewModel(person)
        XCTAssertEqual(viewModel.avatarURL, person.avatar)
    }
    
    func testCreatedDateNotEmpty() {
        let viewModel = PersonDetailViewModel(person)
        XCTAssertGreaterThan(viewModel.createdDateFormatted.count, 0)
    }
    
    func testDetailItemsCount() {
        let viewModel = PersonDetailViewModel(person)
        XCTAssertEqual(viewModel.detailItems.count, 5)
    }
    
    func test_detailItem_ID() {
        let viewModel = PersonDetailViewModel(person)
        let id = viewModel.detailItems.first(where: { $0.title == "ID" })
        XCTAssertEqual(id?.detail, person.id)
    }
    
    func test_detailItem_Email() {
        let viewModel = PersonDetailViewModel(person)
        let id = viewModel.detailItems.first(where: { $0.title == "Email" })
        XCTAssertEqual(id?.detail, person.email)
    }
    
    func test_detailItem_jobTitle() {
        let viewModel = PersonDetailViewModel(person)
        let id = viewModel.detailItems.first(where: { $0.title == "Job Title" })
        XCTAssertEqual(id?.detail, person.jobTitle)
    }
    
    func test_detailItem_favColor() {
        let viewModel = PersonDetailViewModel(person)
        let id = viewModel.detailItems.first(where: { $0.title == "Favourite Color" })
        XCTAssertEqual(id?.detail, person.favouriteColor)
    }
    
    func test_detailItem_created() {
        let viewModel = PersonDetailViewModel(person)
        let id = viewModel.detailItems.first(where: { $0.title == "Created" })
        // TODO: test formatting of date
        XCTAssertNotNil(id?.detail)
    }
}
