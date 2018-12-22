//
//  CoreDataStack.swift
//  Calendar App
//
//  Created by Anderson Gralha on 21/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {

    static var shared = CoreDataStack()
    
     var container: NSPersistentContainer {
        let container = NSPersistentContainer(name: "Contacts")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error: \(error)")
                return 
            }
        }
        
        return container
    }
    
     var managedContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    func saveContext () {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
