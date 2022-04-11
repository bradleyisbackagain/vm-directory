//
//  ItemsTabBarControllerUITests.swift
//  ItemsTabBarControllerUITests
//
//  Created by Bradley Mackey on 07/04/2022.
//

import XCTest
import DirectoryService
@testable import Directory

// TODO: add more UI tests
// For now, just see that the list appears and that we can do basic searches.

class ItemsTabBarControllerUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("UITEST")
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_displaysPeopleCells() throws {
        let cells = app.tables["ListItemTableView"].cells.count
        XCTAssertEqual(cells, 2)
    }
    
    func test_displaysValidTitleNameForFirstCell() throws {
        let cell = app.tables["ListItemTableView"].cells.element(boundBy: 0)
        let title = cell.staticTexts["TitleLabel"].label
        XCTAssertEqual(title, "Tom Jones")
    }
    
    func test_displaysValidSubtitleEmailForFirstCell() throws {
        let cell = app.tables["ListItemTableView"].cells.element(boundBy: 0)
        let title = cell.staticTexts["SubtitleLabel"].label
        XCTAssertEqual(title, "tom.jones@example.com")
    }
    
    func test_filtersCells() throws {
        let table = app.tables["ListItemTableView"]
        // entry not yet filtered
        XCTAssertEqual(table.cells.count, 2)
        
        let searchField = app.searchFields.element(boundBy: 0)
        table.scroll(byDeltaX: 0, deltaY: -100)
        searchField.tap()
        searchField.typeText("Tom")
        
        // the other entry is filtered
        XCTAssertEqual(table.cells.count, 1)
    }
}
