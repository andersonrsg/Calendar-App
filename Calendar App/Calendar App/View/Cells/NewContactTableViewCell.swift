//
//  NewContactTableViewCell.swift
//  Calendar App
//
//  Created by Anderson Gralha on 20/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit

class NewContactTableViewCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    class var MainInformation: String {
        return "NewContactTableViewCellMainInformation"
    }
    
    class var ListInformation: String {
        return "NewContactTableViewCellListInformation"
    }
    
    class var MainInformationSize: CGFloat {
        return 120
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var birthDayTextField: UITextField!
    
    @IBOutlet weak var dataTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupMainInformation() {
        super.setup()
        
        
    }

}
