//
//  DateExtension.swift
//  Contacts App
//
//  Created by Anderson Gralha on 23/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import Foundation

public enum DateFormat: String {
    case dateUS = "MM/dd/yyyy"
    case dateBR = "dd/MM/yyyy"
}

extension Date {
    func formatDateUS() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = DateFormat.dateUS.rawValue
        let convertedDate: String = dateFormatter.string(from: self)
        return convertedDate
    }
}
