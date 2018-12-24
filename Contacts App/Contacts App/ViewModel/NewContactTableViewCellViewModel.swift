//
//  NewContactTableViewCellViewModel.swift
//  Calendar App
//
//  Created by Anderson Gralha on 22/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit

class NewContactTableViewCellViewModel: NSObject {

    // MARK: - Properties
    
    // First Item is a dummy item
    var placeHolderList = ["", "Phone", "Email", "Address"]
    var keyboardTypeList: [UIKeyboardType] = [.asciiCapable, .phonePad, .emailAddress, .asciiCapable]
    var keyboardContentTypeList: [UITextContentType] = [.name, .telephoneNumber, .emailAddress, .fullStreetAddress]
    
    var itemActionList = [#imageLiteral(resourceName: "phone"), #imageLiteral(resourceName: "phone"), #imageLiteral(resourceName: "message")]
    var itemActionColors = [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)]
    
    var iconAdd: UIImage = #imageLiteral(resourceName: "plus")
    var iconRemove: UIImage = #imageLiteral(resourceName: "cancel")
    
    // MARK: - Functions
    func addAction(for textField: UITextField, and index: Int) {
        textField
    }
}
