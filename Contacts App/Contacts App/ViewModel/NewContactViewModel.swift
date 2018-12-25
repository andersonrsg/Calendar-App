//
//  NewContactViewModel.swift
//  Contacts App
//
//  Created by Anderson Gralha on 19/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit
import CoreData

class NewContactViewModel {
    
    // MARK: - Properties
    private var context: NSManagedObjectContext!
    
    var selectedContact: Contact?
    
    // MARK: - Init
    init() {
        self.context = CoreDataStack.shared.persistentContainer.viewContext
    }
    
    // MARK: - Public Functions
    func setupNewContact() {
        selectedContact = Contact(context: context)
    }
    
    func discardChanges() {
        CoreDataStack.shared.discardChanges()
    }
    
    func isLastItem(_ indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case EnumContactDataSection.phone.rawValue:
            return indexPath.row >= selectedContact?.phones?.count ?? 0
        case EnumContactDataSection.email.rawValue:
            return indexPath.row >= selectedContact?.emails?.count ?? 0
        case EnumContactDataSection.address.rawValue:
            return indexPath.row >= selectedContact?.addresses?.count ?? 0
        default:
            return false
        }
    }
    
    func isValidContact(success:() -> Void, error: (String) -> Void) {
        
        if selectedContact?.phones?.allObjects.count == 0 {
            error("Contact should have at least one phone number. ")
        } else if selectedContact?.emails?.allObjects.count == 0 {
            error("Contact should have at least one email. ")
        } else {
            success()
        }
        
    }
    
    func addRow(for indexPath: IndexPath) {
        switch indexPath.section {
        case EnumContactDataSection.phone.rawValue:
            let phone = Phone(context: context)
            phone.phone = ""
            selectedContact?.addToPhones(phone)
        case EnumContactDataSection.email.rawValue:
            let email = Email(context: context)
            email.email = ""
            selectedContact?.addToEmails(email)
        case EnumContactDataSection.address.rawValue:
            selectedContact?.addToAddresses(Address(context: context))
        default:
            break
        }
    }
    
    func removeItem(for indexPath: IndexPath) {
        switch indexPath.section {
        case EnumContactDataSection.phone.rawValue:
            
            if var phones = selectedContact?.phones?.allObjects as? [Phone] {
                selectedContact?.removeFromPhones(phones[indexPath.row])
            }
            
        case EnumContactDataSection.email.rawValue:
            if var emails = selectedContact?.emails?.allObjects as? [Email] {
                selectedContact?.removeFromEmails(emails[indexPath.row])
            }
            
        case EnumContactDataSection.address.rawValue:
            if var addresses = selectedContact?.addresses?.allObjects as? [Address] {
                selectedContact?.removeFromAddresses(addresses[indexPath.row])
            }
            
        default:
            break
        }
    }
    
    func addContact(success: () -> Void, failure: (String) -> Void) {    
        saveChanges(success: success, failure: failure)
    }
    
    
    // MARK: - Private functions
    private func saveChanges(success: () -> Void, failure: (String) -> Void) {
        do {
            try context.save()
            print("DATA SAVED WITH SUCCESS.")
            success()
        } catch {
            print("FAILED TO SAVE DATA: \(error)")
            failure(error.localizedDescription)
        }
    }

}
