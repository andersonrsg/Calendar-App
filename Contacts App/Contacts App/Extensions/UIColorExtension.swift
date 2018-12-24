//
//  UIColorExtension.swift
//  Calendar App
//
//  Created by Anderson Gralha on 21/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit

extension UIColor {
    
    struct ImageTintColors {
        
        static var phoneColor: UIColor {
            return UIColor(red: 51/255, green: 153/255, blue: 255/255, alpha: 1)
        }
        
        static var removeDataColor: UIColor {
            return UIColor.red
        }
        
        static var addNewDataColor: UIColor {
            return UIColor(red: 0/255, green: 153/255, blue: 0/255, alpha: 1)
        }
    }
    
    convenience init(hex: String?) {
        if hex != nil {
            var cString = hex!.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
            
            if cString.hasPrefix("#") {
                cString.remove(at: cString.startIndex)
            }
            
            if cString.count != 6 {
                self.init(white: 1.0, alpha: 1.0)
            } else {
                var rgbValue: UInt32 = 0
                Scanner(string: cString).scanHexInt32(&rgbValue)
                
                self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                          green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                          blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                          alpha: CGFloat(1.0))
            }
            
        } else {
            self.init(red: 255.0, green: 255.0, blue: 255.0, alpha: CGFloat(1.0))
        }
    }
    
}
