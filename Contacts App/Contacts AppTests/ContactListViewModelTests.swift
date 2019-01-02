//
//  ContactListViewModelTests.swift
//  Contacts AppTests
//
//  Created by Anderson Gralha on 25/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import XCTest
@testable import Contacts_App

class ContactListViewModelTests: XCTestCase {
    
    var viewModel: ContactListViewModel!
    var database: Database!
    
    override func setUp() {
        super.setUp()
        viewModel = ContactListViewModel()
        database = Database.shared
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    func testFetchContacts() {
        viewModel.fetchContacts {
            assert(viewModel.contactList != nil)
        }
    }
    
    func testFilterContacts() {
        let contact = Contact()
        contact.id = database.getNewPrimaryKey()
        contact.firstName = "AnderSon"
        contact.lastName = "GraLHA"
        
        database.addContact(contact: contact, success: {
            
            viewModel.fetchContacts {
                viewModel.filterContacts(text: "anderson", {
                    
                    XCTAssert((self.viewModel.searchResults?.count ?? 0) > 0)
                    
                })
            }
            
        }, failure: { _ in
            
            XCTAssert(false)
        })
    }
 
}
