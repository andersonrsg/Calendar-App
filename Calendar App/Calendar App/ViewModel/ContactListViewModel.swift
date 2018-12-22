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
    
    // MARK: Properties
    
    var contactList: NSFetchedResultsController<Contact>!
//    let coreDataStack = CoreDataStack()
    override init() {
        let request: NSFetchRequest<Contact> = Contact.fetchRequest()
        
        let descriptor1 = NSSortDescriptor(key: "firstName", ascending: true)
        request.sortDescriptors = [descriptor1]
        
        contactList = NSFetchedResultsController(fetchRequest: request,
                                                 managedObjectContext: CoreDataStack.shared.managedContext,
                                                 sectionNameKeyPath: nil,
                                                 cacheName:nil)
        
        
        do {
            try contactList.performFetch()
        } catch {
            print("Fetching error: \(error)")
        }
        
    }
    
    
    
}


