//
//  BaseViewController.swift
//  Contacts App
//
//  Created by Anderson Gralha on 22/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlert(title: String? = nil, error: String) {
        let alert = UIAlertController(title: title ?? "Error",
                                      message: error, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel) { _ in }
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
