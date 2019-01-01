//
//  RContact.swift
//  Contacts App
//
//  Created by Anderson Gralha on 30/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit
import RealmSwift

class RContact: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var dateOfBirth: Date?
    
    let phones = List<RPhone>()
    let emails = List<REmail>()
    let addresses = List<RAddress>()
 
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
