//
//  NewContactViewController.swift
//  Calendar App
//
//  Created by Anderson Gralha on 19/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit

class NewContactViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // Mark -- UI
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // Mark -- Actions
    
}

extension NewContactViewController: UITableViewDelegate {
    
}

extension NewContactViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else if section == 1 {
            return 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath) as? NewContactTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
        
    }
    
}
