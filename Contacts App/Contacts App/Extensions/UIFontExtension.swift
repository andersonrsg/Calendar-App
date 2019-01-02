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
        if let font = UIFont(name: "FiraSans-Regular", size: ofSize) {
            return font
        } else {
            return UIFont.systemFont(ofSize: ofSize)
        }
    }
    
    class func textFieldFont(ofSize: CGFloat) -> UIFont {
        if let font = UIFont(name: "Helvetica-Light", size: ofSize) {
            return font
        } else {
            return UIFont.systemFont(ofSize: ofSize)
        }
    }
    
}
