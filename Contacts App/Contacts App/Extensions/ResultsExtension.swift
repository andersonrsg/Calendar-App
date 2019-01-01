//
//  ResultsExtension.swift
//  Contacts App
//
//  Created by Anderson Gralha on 30/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit
import RealmSwift

extension Results {
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}
