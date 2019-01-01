//
//  NewContactViewModelTests.swift
//  Contacts AppTests
//
//  Created by Anderson Gralha on 26/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import XCTest

class NewContactViewModelTests: XCTestCase {

    var viewModel: NewContactViewModel!
    
    override func setUp() {
        
        viewModel = NewContactViewModel()
    }

    override func tearDown() {
        viewModel = nil
    }
    
    func testAddContact() {
        viewModel.setupNewContact()
        
//        let contact = Contact(context: viewModel.context)
//        contact.firstName = "Anderson"
//        contact.lastName = "Gralha"
//        let email = Email(context: viewModel.context)
//        email.email = "anderson.gralha@gmail.com"
//        
//        let phone = Phone(context: viewModel.context)
//        phone.phone = "+5551985666714"
//        
//        viewModel.selectedContact?.addToEmails(email)
//        viewModel.selectedContact?.addToPhones(phone)
//        
//        viewModel.addContact(success: {
//            assert(true)
//        }, failure: { _ in
//            XCTFail("Saving contact failed")
//        })
    }

}
