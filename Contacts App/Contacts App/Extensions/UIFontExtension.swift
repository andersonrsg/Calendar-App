//
//  UIFontExtension.swift
//  Contacts App
//
//  Created by Anderson Gralha on 21/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit

extension UIFont {
    class func defaultFont(ofSize: CGFloat) -> UIFont {
        if let font = UIFont(name: "OpenSans-Regular", size: ofSize) {
            return font
        } else {
            return UIFont.systemFont(ofSize: ofSize)
        }
    }
    
    class func textFieldFont(ofSize: CGFloat) -> UIFont {
        if let font = UIFont(name: "OpenSans-SemiBold", size: ofSize) {
            return font
        } else {
            return UIFont.systemFont(ofSize: ofSize)
        }
    }
    
    class func textFieldHeaderFont(ofSize: CGFloat) -> UIFont {
        if let font = UIFont(name: "OpenSans-Light", size: ofSize) {
            return font
        } else {
            return UIFont.systemFont(ofSize: ofSize)
        }
    }
}
