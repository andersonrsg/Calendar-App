//
//  DatabaseTests.swift
//  Contacts AppTests
//
//  Created by Anderson Gralha on 01/01/19.
//  Copyright © 2019 andersongralha. All rights reserved.
//

import XCTest
@testable import Contacts_App

class DatabaseTests: XCTestCase {
    
    var database: Database!
    
    override func setUp() {
        database = Database.shared
    }
    
    override func tearDown() {
        //        database.truncateDatabase()
        //        database = nil
    }
    
    func testAddContact() {
        
        let contact = Contact()
        contact.id = database.getNewPrimaryKey()
        contact.firstName = "Test"
        
        database.addContact(contact: contact, success: {
            
            XCTAssert(true)
        }, failure: { _ in
            XCTFail("Saving contact failed")
        })
        
    }
    
    func testRemoveContact() {
        let contact = Contact()
        contact.id = database.getNewPrimaryKey()
        contact.firstName = "Test"
        
        database.addContact(contact: contact, success: {
            
            self.database.removeContact(contact: contact, success: {
                XCTAssert(true)
            }, failure: { _ in
                XCTFail("Removing contact failed")
            })
            
        }, failure: { _ in
            XCTFail("Removing contact failed")
        })
    }
    
    func testUpdateContact() {
        
        let contact = Contact()
        contact.id = database.getNewPrimaryKey()
        contact.firstName = "Test"
        
        database.addContact(contact: contact, success: {
            
            database.updateContact(
                contact: contact,
                firstName: "Jose",
                success: {
                    
                    XCTAssertTrue(
                        contact.firstName == "Jose"
                    )
                    
            }, failure: nil)
            
        }, failure: { _ in
            XCTFail("Updating contact failed")
        })
    }
    
    func testUpdateContact2() {
        
        let contact = Contact()
        contact.id = database.getNewPrimaryKey()
        contact.firstName = "Test"
        
        let email = Email()
        email.email = "Test"
        
        database.addContact(contact: contact, success: {
            
            self.database.updateContact(contact: contact,
                                        email: email,
                                        index: 0,
                                        success: {
                                            
                                            XCTAssert(
                                                contact.emails.first?.email == "Test"
                                            )
                                            
            }, failure: { _ in
                XCTFail("Updating contact failed")
            })
            
        }, failure: { _ in
            XCTFail("Updating contact failed")
        })
    }
    
    func testRemovePhone() {
        
        let contact = Contact()
        contact.id = database.getNewPrimaryKey()
        contact.firstName = "Test"
        
        let phone1 = Phone()
        phone1.phone = "55555"
        
        let phone2 = Phone()
        phone2.phone = "77777"
        
        contact.phones.append(objectsIn: [phone1, phone2])
        
        database.addContact(contact: contact, success: {
            
            self.database.updateContact(contact: contact,
                                        phone: true,
                                        index: 0,
                                        remove: true,
                                        success: {
                                            
                                            XCTAssert(
                                                contact.phones.first?.phone == "77777"
                                            )
                                            
            }, failure: { _ in
                XCTFail("Updating contact failed.")
            })
            
        }, failure: { _ in
            XCTFail("Updating contact failed.")
        })
    }
    
    func testTrucateDatabase() {
        database.truncateDatabase()
        database.fetchContacts(success: { contacts in
            XCTAssertTrue(contacts.count == 0)
        }, failure: { _ in
            XCTFail("Truncate database failed.")
        })
    }
    
}
