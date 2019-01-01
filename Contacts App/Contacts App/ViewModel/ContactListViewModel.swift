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
    var contactList: [RContact]?
    
    var searchResults: [RContact]?
    
    var isSearching = false
    
    var selectedContact: RContact?
    
    // MARK: - Init
    override init() {
        
    }
    
    // MARK: - Actions
    func addBookmarks(success: () -> Void) {
        // Remove all contacts and add a dummy one
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        let deleteRequet = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            
            try CoreDataStack.shared.persistentContainer.persistentStoreCoordinator.execute(
                deleteRequet,
                with: CoreDataStack.shared.persistentContainer.viewContext
            )
            
        } catch {
            print(error)
        }
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        
        let contact = Contact(context: context)
        contact.firstName = "Anderson"
        contact.lastName = "Gralha"
        let email = Email(context: context)
        email.email = "anderson.gralha@gmail.com"
        
        let phone = Phone(context: context)
        phone.phone = "+5551985666714"
        
        contact.addToEmails(email)
        contact.addToPhones(phone)
        
        CoreDataStack.shared.saveContext()
        fetchContacts {
            success()
        }
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
    
//    func saveChanges() {
//        do {
//            try contactList.managedObjectContext.save()
//            fetchContacts {}
//        } catch {
//            print(error)
//        }
//    }
    
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
