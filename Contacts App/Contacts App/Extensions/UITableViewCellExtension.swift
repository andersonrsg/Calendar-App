//
//  UITableViewCellExtension.swift
//  Contacts App
//
//  Created by Anderson Gralha on 21/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    func removeSelectionHighlight() {
        self.selectionStyle = .none
    }
    
    func addSelectionHighlight() {
        self.selectionStyle = .default
    }
}
