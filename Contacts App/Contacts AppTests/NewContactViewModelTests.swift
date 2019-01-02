//
//  NewContactViewModelTests.swift
//  Contacts AppTests
//
//  Created by Anderson Gralha on 26/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import XCTest
@testable import Contacts_App

class NewContactViewModelTests: XCTestCase {
    
    var viewModel: NewContactViewModel!
    
    var database: Database!
    
    override func setUp() {
        viewModel = NewContactViewModel()
        database = Database.shared
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func testAddContact() {
        database.truncateDatabase()
        
        viewModel.setupNewContact()
        
        let contact = Contact()
        contact.id = database.getNewPrimaryKey()
        contact.firstName = "Test"
        
        viewModel.selectedContact = contact
        viewModel.addContact(success: {
            database.fetchContacts(success: { contacts in
                XCTAssertTrue(contacts.count > 0)
            }, failure: { _ in
                XCTFail("Saving contact failed")
            })
        }, failure: { _ in
            XCTFail("Saving contact failed")
        })
        
    }
    
}
