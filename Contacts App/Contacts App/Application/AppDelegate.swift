//
//  AppDelegate.swift
//  Contacts App
//
//  Created by Anderson Gralha on 19/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import HockeySDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Setup Hockey App
        BITHockeyManager.shared().configure(withIdentifier: "com.AndersonGralha.ContactApp")
        BITHockeyManager.shared().start()
        BITHockeyManager.shared().authenticator.authenticateInstallation() 
        
        // Setup Keyboard Manager
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        return true
    }

}
