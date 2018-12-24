//
//  NewContactTableViewCellViewModel.swift
//  Calendar App
//
//  Created by Anderson Gralha on 22/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit

class NewContactTableViewCellViewModel: NSObject {

    var placeHolderList = ["", "Phone", "Email", "Address"]
    var keyboardTypeList: [UIKeyboardType] = [.asciiCapable, .phonePad, .emailAddress, .asciiCapable]
    var keyboardContentTypeList: [UITextContentType] = [.name, .telephoneNumber, .emailAddress, .fullStreetAddress]
    
    var iconAdd: UIImage = #imageLiteral(resourceName: "plus")
    var iconRemove: UIImage = #imageLiteral(resourceName: "cancel")
}
