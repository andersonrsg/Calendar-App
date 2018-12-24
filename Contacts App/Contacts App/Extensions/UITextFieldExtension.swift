//
//  UITextFieldExtension.swift
//  Calendar App
//
//  Created by Anderson Gralha on 21/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit

extension UITextField {

    func addLeftView(image: UIImage) {
        self.leftViewMode = .always
        self.leftView = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        (self.leftView as? UIImageView)?.image = image
    }
    
    func addRightView(image: UIImage) {
        self.rightViewMode = .always
        self.rightView = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        (self.rightView as? UIImageView)?.image = image
    }

}
