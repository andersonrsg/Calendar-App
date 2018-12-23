//
//  BaseViewController.swift
//  Calendar App
//
//  Created by Anderson Gralha on 22/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showAlert(title: String? = nil, error: String) {
        let alert = UIAlertController(title: title ?? "Error", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { action in
        }

        alert.addAction(action)
    }
}
