//
//  ContactListTableViewController.swift
//  Calendar App
//
//  Created by Anderson Gralha on 19/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit

class ContactListTableViewController: UITableViewController {

    // MARK: - Properties
    
    fileprivate lazy var viewModel = ContactListViewModel()
    
    static let NewContactMainInformation = "NewContactTableViewCellMainInformation"
    
    static let NewContactListInformation = "NewContactTableViewCellListInformation"
    
    // MARK: - Outlets
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contactList.sections?[section].objects?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? ContactListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setup(contact: viewModel.contactList.object(at: indexPath))
        
        return cell
    }
    
    // MARK: - Table view delegate
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let actionDelete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, view, completion  in
//
//            completion(true)
//        }
//
////        actionDelete.image = #imageLiteral(resourceName: <#T##String#>)
//        actionDelete.backgroundColor = .red
//
//        return UISwipeActionsConfiguration(actions: [actionDelete])
//    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, view, completion  in
            
            completion(true)
        }
        
//        actionDelete.image = #imageLiteral(resourceName: )
        actionDelete.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [actionDelete])
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    // MARK: Actions
    
    @IBAction func didPressNewContactButton(_ sender: Any) {
        self.performSegue(withIdentifier: "GoToNewContactView", sender: self)
    }
    
    
}

