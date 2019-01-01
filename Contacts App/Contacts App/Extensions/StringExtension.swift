//
//  StringExtension.swift
//  Contacts App
//
//  Created by Anderson Gralha on 01/01/19.
//  Copyright © 2019 andersongralha. All rights reserved.
//

import Foundation

extension String {
    
    static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...length-1).map{ _ in letters.randomElement()! })
    }
    
}
