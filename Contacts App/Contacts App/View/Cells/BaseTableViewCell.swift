//
//  BaseTableViewCell.swift
//  Calendar App
//
//  Created by Anderson Gralha on 21/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup() {
        self.removeSelectionHighlight()
    }
    
    func addAcessoryView() {
        self.accessoryType = .disclosureIndicator
    }
    
}
