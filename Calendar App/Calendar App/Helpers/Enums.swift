//
//  Enums.swift
//  Calendar App
//
//  Created by Anderson Gralha on 22/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

// Data sent from the 'new contact table view cell' to the view controller.
enum EnumDataField {
    case firstName
    case lastName
    case birthday
    case address(index: Int)
    case phone(index: Int)
    case email(index: Int)
    
    
}

// Viewing type on the 'new contact view controller'.
enum EnumNewContactViewModel {
    case new
    case view
    case edit
}

// Section controller for contact data
enum EnumContactDataSection: Int {
    case primary = 0
    case phone = 1
    case email = 2
    case address = 3
}
