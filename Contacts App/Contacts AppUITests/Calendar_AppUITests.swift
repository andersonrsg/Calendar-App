//
//  Calendar_AppUITests.swift
//  Contacts AppUITests
//
//  Created by Anderson Gralha on 19/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import XCTest

class Calendar_AppUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens
        // for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation -
        // required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testAddContact() {
        
        let app = XCUIApplication()
        app.navigationBars["Contacts"].buttons["Add"].tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.textFields["First name"]/*[[".cells.textFields[\"First name\"]",".textFields[\"First name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let toolbar = app.toolbars["Toolbar"]
        let toolbarDoneButtonButton = toolbar.buttons["Toolbar Done Button"]
        toolbarDoneButtonButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.textFields["Last name"]/*[[".cells.textFields[\"Last name\"]",".textFields[\"Last name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        toolbar.buttons["Toolbar Next Button"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.textFields["Birthday"]/*[[".cells.textFields[\"Birthday\"]",".textFields[\"Birthday\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let phoneTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Phone"]/*[[".cells.textFields[\"Phone\"]",".textFields[\"Phone\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        phoneTextField.swipeUp()
        phoneTextField.tap()
        toolbarDoneButtonButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.textFields["Email"]/*[[".cells.textFields[\"Email\"]",".textFields[\"Email\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        toolbarDoneButtonButton.tap()
        app.navigationBars["New Contact"].buttons["Done"].tap()
        
    }
    
    func testRemoveContact() {
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery.cells.children(matching: .button).element.swipeLeft()
        tablesQuery.buttons["Delete"].tap()
        
    }

}
