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
    var selectedContact: Contact?
    
    // Set the isUpdating contact false if adding a new contact
    var isUpdating = true
    
    // MARK: - Init
    init() {
    }
    
    // MARK: - Public Functions
    func setupNewContact() {
        selectedContact = Contact()
        selectedContact?.id = Database.shared.getNewPrimaryKey()
        isUpdating = false
    }
    
    func isLastItem(_ indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case EnumContactDataSection.phone.rawValue:
            return indexPath.row >= selectedContact?.phones.count ?? 0
        case EnumContactDataSection.email.rawValue:
            return indexPath.row >= selectedContact?.emails.count ?? 0
        case EnumContactDataSection.address.rawValue:
            return indexPath.row >= selectedContact?.addresses.count ?? 0
        default:
            return false
        }
    }
    
    func isValidContact(success:() -> Void, error: (String) -> Void) {
        
        if selectedContact?.phones.count == 0 {
            error("Contact should have at least one phone number. ")
        } else if selectedContact?.emails.count == 0 {
            error("Contact should have at least one email. ")
        } else {
            success()
        }
        
    }
    
    func addRow(for indexPath: IndexPath, update: Bool? = false) {
        guard let contact = selectedContact else {
            return
        }
        switch indexPath.section {
        case EnumContactDataSection.phone.rawValue:
            let phone = Phone()
            
            if update ?? false {
                Database.shared.updateContact(contact: contact,
                                              phone: phone,
                                              index: contact.phones.count)
            } else {
                contact.phones.append(phone)
            }
        case EnumContactDataSection.email.rawValue:
            let email = Email()
            
            if update ?? false {
                Database.shared.updateContact(contact: contact,
                                              email: email,
                                              index: contact.emails.count)
            } else {
                contact.emails.append(email)
            }
            
        case EnumContactDataSection.address.rawValue:
            let address = Address()
            
            if update ?? false {
                Database.shared.updateContact(contact: contact,
                                              address: address,
                                              index: contact.addresses.count)
            } else {
                contact.addresses.append(address)
            }
            
        default:
            break
        }
    }
    
    func removeItem(for indexPath: IndexPath) {
        guard let contact = selectedContact else {
            return
        }
        switch indexPath.section {
        case EnumContactDataSection.phone.rawValue:
            
            if isUpdating {
                
                Database.shared.updateContact(contact: contact,
                                              phone: true,
                                              index: indexPath.row,
                                              remove: true)
                
            } else {
                contact.phones.remove(at: indexPath.row)
            }
            
        case EnumContactDataSection.email.rawValue:
            
            if isUpdating {
                
                Database.shared.updateContact(contact: contact,
                                              email: true,
                                              index: indexPath.row,
                                              remove: true)
                
            } else {
                selectedContact?.emails.remove(at: indexPath.row)
            }
            
        case EnumContactDataSection.address.rawValue:
            
            if isUpdating {
                
                Database.shared.updateContact(contact: contact,
                                              address: true,
                                              index: indexPath.row,
                                              remove: true)
                
            } else {
                selectedContact?.addresses.remove(at: indexPath.row)
            }
            
        default:
            break
        }
    }
    
    func addContact(success: () -> Void, failure: (String) -> Void) {
        
        if let contact = selectedContact {
            
            Database.shared.addContact(
                contact: contact,
                success: {
                    success()
            }, failure: { error in
                failure(error)
            })
            
        } else {
            failure("Failed to add contact. Error 11.")
        }
    }
    
    // MARK: - Update Contact Functions
    
    func setFirstName(_ value: String) {
        guard let contact = selectedContact else {
            return
        }
        if isUpdating {
            Database.shared.updateContact(contact: contact,
                                      firstName: value)
        } else {
            contact.firstName = value
        }
    }
    
    func setLastName(_ value: String) {
        guard let contact = selectedContact else {
            return
        }
        if isUpdating {
            Database.shared.updateContact(contact: contact,
                                          lastName: value)
        } else {
            contact.lastName = value
        }
    }
    
    func setBirthDate(_ value: Date) {
        guard let contact = selectedContact else {
            return
        }
        if isUpdating {
            Database.shared.updateContact(contact: contact,
                                          birthDate: value)
        } else {
            contact.dateOfBirth = value
        }
    }
    
    func setPhone(_ value: String, forIndex: Int) {
        guard let contact = selectedContact else {
            return
        }
        if isUpdating {
            let phone = Phone()
            phone.phone = value
            Database.shared.updateContact(contact: contact,
                                          phone: phone,
                                          index: forIndex)
        } else {
            contact.phones[forIndex].phone = value
        }
    }
    
    func setEmail(_ value: String, forIndex: Int) {
        guard let contact = selectedContact else {
            return
        }
        if isUpdating {
            let email = Email()
            email.email = value
            Database.shared.updateContact(contact: contact,
                                          email: email,
                                          index: forIndex)
        } else {
            contact.emails[forIndex].email = value
        }
    }
    
    func setAddress(_ value: String, forIndex: Int) {
        guard let contact = selectedContact else {
            return
        }
        if isUpdating {
            let address = Address()
            address.address = value
            Database.shared.updateContact(contact: contact,
                                          address: address,
                                          index: forIndex)
        } else {
            contact.addresses[forIndex].address = value
        }
    }
    
}
