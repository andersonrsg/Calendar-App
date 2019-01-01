//
//  ContactListTableViewCell.swift
//  Contacts App
//
//  Created by Anderson Gralha on 21/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit

class ContactListTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private var contact: RContact?
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    
    // MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Public Functions
    func setup(newContact: RContact?) {
        guard let contact = newContact else {
            return
        }
        
        self.contact = contact
        
        var labelText = ""
        labelText = contact.firstName.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let lastName = contact.lastName.trimmingCharacters(in: .whitespacesAndNewlines)
        if !lastName.isEmpty {
            labelText = "\(labelText) \(lastName)"
        }
        if labelText == "" {
            labelText = "No Name"
            titleLabel?.font = UIFont.italicSystemFont(ofSize: titleLabel?.font.pointSize ?? 17)
        } else {
            titleLabel?.font = UIFont.systemFont(ofSize: titleLabel?.font.pointSize ?? 17)
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
        
        let phone = contact.phones.first
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
