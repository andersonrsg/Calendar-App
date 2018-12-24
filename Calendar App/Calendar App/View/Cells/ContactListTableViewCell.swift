//
//  ContactListTableViewCell.swift
//  Calendar App
//
//  Created by Anderson Gralha on 21/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit

class ContactListTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var contact: Contact?
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setup(contact: Contact?) {
        guard let contact = contact else {
            return
        }
        
        self.contact = contact
        
        var labelText = ""
        labelText = contact.firstName?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if let lastName = contact.lastName {
            labelText = "\(labelText) \(lastName)".trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        if labelText == "" {
            
            labelText = "No Name"
            titleLabel?.font = UIFont.italicSystemFont(ofSize: titleLabel?.font.pointSize ?? 17)
        }
        
        titleLabel?.text = labelText
        
        callButton.tintColor = UIColor.ImageTintColors.phoneColor
    }
    
    // MARK: - Actions
    
    @IBAction func didPressCallButton(_ sender: Any) {
        performCall()
    }
    
    // MARK: - Private Functions
    
    private func performCall() {
        guard let contact = contact else {
            return
        }
        
        let phone = contact.phones?.allObjects.first as? Phone
        if var phoneNumber = phone?.phone, phoneNumber != "" {
            phoneNumber = phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines)
            if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
                
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
                
            }
            
        }
    }
}
