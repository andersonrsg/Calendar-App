//
//  NewContactViewModel.swift
//  Calendar App
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
    
    // MARK: -

    func setupNewContact() {
        selectedContact = Contact(context: context)
        selectedContact?.addToAddresses(Address(context: context))
        selectedContact?.addToEmails(Email(context: context))
        selectedContact?.addToPhones(Phone(context: context))
    }

    func validateData() {

    }

    func addAddress(address: String) {

    }

    func addEmail() {

    }

    func isLastItem(_ indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case 1:
            return indexPath.row >= selectedContact?.phones?.count ?? 0
        case 2:
            return indexPath.row >= selectedContact?.emails?.count ?? 0
        case 3:
            return indexPath.row >= selectedContact?.addresses?.count ?? 0
        default:
            return false
        }
    }

    func addContact(success: () -> Void, failure: (String) -> Void) {

        let contact = Contact(context: context)
        contact.firstName = "teste silva"
        let email = Email(context: context)
        email.email = "teste.teste"
        
        let phone = Phone(context: context)
        phone.phone = "tedsasjd"
//
        contact.addToEmails(email)
        contact.addToPhones(phone)
        
        saveChanges(success: success, failure: failure)
    }

    func updateContact(contact: Contact, success: () -> Void, failure: (String) -> Void) {


        saveChanges(success: success, failure: failure)
    }

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


    init() {
        self.context = CoreDataStack.shared.persistentContainer.viewContext
    }
}
