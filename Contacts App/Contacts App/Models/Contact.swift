//
//  RContact.swift
//  Contacts App
//
//  Created by Anderson Gralha on 30/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit
import RealmSwift

class Contact: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var dateOfBirth: Date?
    
    var phones = List<Phone>()
    var emails = List<Email>()
    var addresses = List<Address>()
 
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
