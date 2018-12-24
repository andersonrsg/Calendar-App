//
//  ContactListTableViewCell.swift
//  Calendar App
//
//  Created by Anderson Gralha on 21/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit

class ContactListTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setup(contact: Contact) {
        var labelText = ""
        labelText = contact.firstName?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if let lastName = contact.lastName {
            labelText = "\(labelText) \(lastName)".trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        if labelText == "" {
        
            labelText = "No Name"
            textLabel?.font = UIFont.italicSystemFont(ofSize: textLabel?.font.pointSize ?? 17)
        }
        
        textLabel?.text = labelText
    }
}
