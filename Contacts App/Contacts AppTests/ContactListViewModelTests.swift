//
//  ContactListViewModelTests.swift
//  Contacts AppTests
//
//  Created by Anderson Gralha on 25/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import XCTest
import CoreData

class ContactListViewModelTests: XCTestCase {
    
    var viewModel: ContactListViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ContactListViewModel()
        
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
 
}
