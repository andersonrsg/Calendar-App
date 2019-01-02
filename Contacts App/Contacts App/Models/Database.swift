//
//  Database.swift
//  Contacts App
//
//  Created by Anderson Gralha on 30/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit
import RealmSwift

final class Database {
    // MARK: - Properties
    static let shared = Database()
    
    private var db: Realm?
    
    // MARK: - Init
    init() {
        do {
            db = try Realm()
        } catch {
            fatalError("Failed to start Realm. Error 50.")
        }
        
    }
    
    // MARK: - Public Functions
    
    func addContact(contact: Contact, success: () -> Void, failure: (String) -> Void) {
        
        do {
            try db?.write {
                db?.add(contact)
            }
            success()
        } catch {
            failure("Failed to save contact. Error 10.")
        }
        
    }
    
    func fetchContacts(success: ([Contact]) -> Void, failure: (String) -> Void) {
        
        let contacts = db?.objects(Contact.self).sorted(byKeyPath: "firstName", ascending: true)
        
        success(contacts?.toArray(type: Contact.self) ?? [])
        
    }
    
    func removeContact(contact: Contact?, success: () -> Void, failure: (String) -> Void) {
        if let contact = contact {
            do {
                try db?.write {
                    db?.delete(contact)
                }
                success()
            } catch {
                failure("Failed to remove contact. Error 20")
            }
        }
    }
    
    func updateContact(contact: Contact,
                       email: Email? = nil,
                       address: Address? = nil,
                       phone: Phone? = nil,
                       index: Int,
                       success: (() -> Void)? = nil,
                       failure: ((String) -> Void)? = nil) {
        
        do {
            try db?.write {
                
                if let email = email {
                    
                    if contact.emails.count == index {
                        contact.emails.append(Email())
                    }
                    
                    contact.emails[index] = email
                    
                } else if let address = address {
                    if contact.addresses.count == index {
                        contact.addresses.append(Address())
                    }
                    
                    contact.addresses[index] = address
                    
                } else if let phone = phone {
                    if contact.phones.count == index {
                        contact.phones.append(Phone())
                    }
                    
                    contact.phones[index] = phone
                    
                }
                
                db?.add(contact, update: true)
                
            }
            success?()
        } catch {
            failure?("Failed to update contact. Error 30.")
        }
    }
    
    func updateContact(contact: Contact,
                       email: Bool? = false,
                       address: Bool? = false,
                       phone: Bool? = false,
                       index: Int,
                       remove: Bool = false,
                       success: (() -> Void)? = nil,
                       failure: ((String) -> Void)? = nil) {
        
        do {
            try db?.write {
                
                if email ?? false {
                    
                    if remove {
                        contact.emails.remove(at: index)
                    }
                    
                } else if address ?? false {
                    
                    if remove {
                        contact.addresses.remove(at: index)
                    }
                    
                } else if phone ?? false {
                    
                    if remove {
                        contact.phones.remove(at: index)
                    }
                    
                }
                
                db?.add(contact, update: true)
                
            }
            success?()
        } catch {
            failure?("Failed to update contact. Error 32.")
        }
    }
    
    func updateContact(contact: Contact,
                       firstName: String? = nil,
                       lastName: String? = nil,
                       birthDate: Date? = nil,
                       success: (() -> Void)? = nil,
                       failure: ((String) -> Void)? = nil) {
        
        do {
            try db?.write {
                
                if let firstName = firstName {
                    contact.firstName = firstName
                } else if let lastName = lastName {
                    contact.lastName = lastName
                } else if let birthDate = birthDate {
                    contact.dateOfBirth = birthDate
                }
                
                db?.add(contact, update: true)
                
            }
            success?()
        } catch {
            failure?("Failed to update contact. Error 31.")
        }
    }
    
    func truncateDatabase() {
        
        do {
            try db?.write {
                
                let contacts = db?.objects(Contact.self)
                if let contacts = contacts {
                    db?.delete(contacts)
                }
                
            }
        } catch {
        }
        
    }
    
    func getNewPrimaryKey() -> String {
        return String.randomString(length: 30)
    }
    
}
