//
//  NewContactViewController.swift
//  Calendar App
//
//  Created by Anderson Gralha on 19/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit

class NewContactViewController: UIViewController {

    // MARK: - Properties
    
    fileprivate lazy var viewModel = NewContactViewModel()
    
    @IBOutlet weak var tableView: UITableView!

    
    // Mark -- UI
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.texte()
    }
    
    // Mark -- Actions
    
//    @IBAction func didPressCancelButton(_ sender: Any) {
//        self.navigationController?.dismiss(animated: true, completion: nil)
//    }
    
    @IBAction func didPressDoneButton(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension NewContactViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return NewContactTableViewCell.MainInformationSize
        } else {
            return 0
        }
    }
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
        
        if indexPath.section == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath) as? NewContactTableViewCell else {
                return UITableViewCell()
            }
            
//            cell.dataTextField.delegate = self
            
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath) as? NewContactTableViewCell else {
                return UITableViewCell()
            }
            
//            cell.dataTextField.delegate = self
            
            return cell
        }
        
    }
    
}
