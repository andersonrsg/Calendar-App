//
//  Session.swift
//  Calendar App
//
//  Created by Anderson Gralha on 21/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import Foundation

enum SessionDataType: String {
    case bool
    case string
    case object
}

enum SessionData: String {

    case UUID
    case firstLogin

    var type: SessionDataType {
        switch self {
        case .UUID:
            return .string
        case .firstLogin:
            return .bool
        }
    }

}

final class Session {

    public static var shared = Session()
    
    var uuid: String {
        set {
            update(.UUID, value: newValue)
        }
        get {
            guard let uuid = load(.UUID) as? String else { return "" }
            return uuid
        }
    }
    
    var firtsLogin: Bool {
        set {
            update(.firstLogin, value: newValue)
        }
        get {
            guard let firtsLogin = load(.firstLogin) as? Bool else { return false }
            return firtsLogin
        }
    }

    private func update(_ data: SessionData, value: Any?) {
        switch data.type {
        case .object:
            guard let value = value else { return }
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: value)
            UserDefaults.standard.set(encodedData, forKey: data.rawValue)
            UserDefaults.standard.synchronize()
        default:
            UserDefaults.standard.set(value, forKey: data.rawValue)
            UserDefaults.standard.synchronize()
        }
    }

    private func load(_ data: SessionData) -> Any? {
        switch data.type {
        case .string:
            return UserDefaults.standard.string(forKey: data.rawValue)
        case .bool:
            return UserDefaults.standard.bool(forKey: data.rawValue)
        case .object:
            guard let decoded = UserDefaults.standard.object(forKey: data.rawValue) as? Data else {
                return nil
            }
            return NSKeyedUnarchiver.unarchiveObject(with: decoded)
        }
    }

}
