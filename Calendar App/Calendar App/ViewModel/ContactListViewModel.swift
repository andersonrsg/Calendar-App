//
//  ContactListViewModel.swift
//  Calendar App
//
//  Created by Anderson Gralha on 19/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit
import CoreData

class ContactListViewModel: NSObject {
    
    // MARK: - Properties
    var contactList: NSFetchedResultsController<Contact>!
    
    var searchResults: [Contact]?
    
    var isSearching = false
    
    var selectedContact: Contact?
    
    // MARK: - Init
    
    override init() {
        
    }
    
    // MARK: - Actions
    
    func addBookmarks(success: () -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        let deleteRequet = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try CoreDataStack.shared.persistentContainer.persistentStoreCoordinator.execute(deleteRequet, with: CoreDataStack.shared.persistentContainer.viewContext)
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
    
    func fetchContacts(success: () -> Void) {
        let request: NSFetchRequest<Contact> = Contact.fetchRequest()
        
        let descriptor1 = NSSortDescriptor(key: "firstName", ascending: true)
        let descriptor2 = NSSortDescriptor(key: "lastName", ascending: true)
        
        request.sortDescriptors = [descriptor1, descriptor2]
        
        contactList = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: CoreDataStack.shared.persistentContainer.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        do {
            try contactList.performFetch()
            
            success()
        } catch {
            print("Fetching error: \(error)")
        }
        
    }
    
    func saveChanges() {
        do {
            try contactList.managedObjectContext.save()
            fetchContacts {}
        } catch {
            print(error)
        }
    }
    
    func filterContacts(text: String, _ callback: @escaping () -> Void) {
        let lowerCasedText = text.lowercased()
        
        searchResults = contactList.fetchedObjects?.filter {
            let firstName = $0.firstName?.lowercased().contains(lowerCasedText) ?? false
            let lastName = $0.lastName?.lowercased().contains(lowerCasedText) ?? false
            
            return firstName || lastName
        }
        
        callback()
    }
    
}
