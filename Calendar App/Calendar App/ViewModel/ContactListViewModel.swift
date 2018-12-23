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
    var selectedContact: Contact?
    // MARK: -

    override init() {

    }

    // MARK: - Actions

    func fetchContacts(success: () -> Void) {
        let request: NSFetchRequest<Contact> = Contact.fetchRequest()

        let descriptor1 = NSSortDescriptor(key: "firstName", ascending: true)
        let descriptor2 = NSSortDescriptor(key: "lastName", ascending: true)
        
        request.sortDescriptors = [descriptor1, descriptor2]

        contactList = NSFetchedResultsController(fetchRequest: request,
                                                 managedObjectContext: CoreDataStack.shared.persistentContainer.viewContext,
                                                 sectionNameKeyPath: nil,
                                                 cacheName: nil)

        do {
            try contactList.performFetch()
            success()
        } catch {
            print("Fetching error: \(error)")
        }

    }

}
