//
//  MilkyWayAppUITests.swift
//  MilkyWayAppUITests
//
//  Created by David Tverdota on 04/11/2018.
//  Copyright © 2018 Emese Toth. All rights reserved.
//

import XCTest

class MilkyWayAppUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCellTap() {
        let app = XCUIApplication()
        
        let title = app.staticTexts["cellTitleId"]
        waitForElementToAppear(title)
        
        let tableview = app.tables.containing(.table, identifier: "MilkyWayTableId")
        XCTAssertTrue(tableview.cells.count > 0)
        
        let cell = tableview.cells.element(boundBy: 0)
        cell.tap()
        
        let titleLabel = app.staticTexts["detailTitleId"]
        waitForElementToAppear(titleLabel)

        XCTAssertFalse(titleLabel.exists)
    }
    
    func waitForElementToAppear(_ element: XCUIElement) {
        let existsPredicate = NSPredicate(format: "exists == true")
        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: 15, handler: nil)
    }

}


