//
//  ContactListViewModel.swift
//  Contacts App
//
//  Created by Anderson Gralha on 19/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit
import CoreData

class ContactListViewModel: NSObject {
    
    // MARK: - Properties
    var contactList: [Contact]?
    
    var searchResults: [Contact]?
    
    var isSearching = false
    
    var selectedContact: Contact?
    
    // MARK: - Init
    override init() {
        
    }
    
    // MARK: - Actions
    func addBookmarks(success: () -> Void) {
        // Add a dummy contact
        
        let contact = Contact()
        let email = Email()
        let phone = Phone()
        
        email.email = "anderson.gralha@gmail.com"
        phone.phone = "+5551985666714"
        
        contact.id = Database.shared.getNewPrimaryKey()
        contact.firstName = "Anderson"
        contact.lastName = "Gralha"
        contact.emails.append(email)
        contact.phones.append(phone)
        
        Database.shared.addContact(contact: contact, success: {
            fetchContacts {
                success()
            }
        }, failure: { _ in
        })
        
    }
    
    // MARK: - Public Functions
    func fetchContacts(success: () -> Void) {
        
        Database.shared.fetchContacts(success: { contacts in
            self.contactList = contacts
            success()
        }, failure: { error in
            print("ERROR: \(error)")
        })
        
    }
    
    func filterContacts(text: String, _ callback: @escaping () -> Void) {
        let lowerCasedText = text.lowercased()
        
        searchResults = contactList?.filter {
            let firstName = $0.firstName.lowercased().contains(lowerCasedText)
            let lastName = $0.lastName.lowercased().contains(lowerCasedText)
            
            return firstName || lastName
        }
        
        callback()
    }
    
}
