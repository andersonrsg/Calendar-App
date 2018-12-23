//
//  ContactListTableViewController.swift
//  Calendar App
//
//  Created by Anderson Gralha on 19/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit
import CoreData

class ContactListTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    lazy var viewModel = ContactListViewModel()

    //    private let refreshControl = UIRefreshControl()

    //    static let NewContactMainInformation = "NewContactTableViewCellMainInformation"
    //
    //    static let NewContactListInformation = "NewContactTableViewCellListInformation"
    //


    // MARK: - Outlets
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupRefreshControl()
        self.refreshContactList(self)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }

    // MARK: - UI

    func setupRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshContactList(_:)), for: .valueChanged)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let destination = segue.destination as? NewContactViewController {
            destination.delegate = self

            if segue.identifier == "GoToNewContactView" {
                destination.viewMode = .new
            } else {
                destination.viewMode = .view
                destination.viewModel.selectedContact = viewModel.selectedContact
//                destination.viewModel.contactList = viewModel.contactList
            }
        }

    }
    
    // MARK: Actions

    @objc private func refreshContactList(_ sender: Any) {
        self.viewModel.fetchContacts(success: { [weak self] in
            self?.tableView.reloadData()
            self?.refreshControl?.endRefreshing()
        })
    }
    
    @IBAction func didPressNewContactButton(_ sender: Any) {
        self.performSegue(withIdentifier: "GoToNewContactView", sender: self)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.contactList?.sections?[section].objects?.count ?? 0)
        return viewModel.contactList?.sections?[section].objects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListTableViewCellEntry",
                                                       for: indexPath) as? ContactListTableViewCell else {
                                                        return UITableViewCell()
        }
        
        cell.setup(contact: viewModel.contactList.object(at: indexPath))
        
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView,
                            trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let actionDelete = UIContextualAction(style: .destructive,
                                              title: "Delete") { [weak self] action, view, completion  in

                                                if let contact = self?.viewModel.contactList.object(at: indexPath) {
                                                    self?.viewModel.contactList.managedObjectContext.delete(contact)
                                                    do {
                                                        try self?.viewModel.contactList.managedObjectContext.save()
                                                    } catch {
                                                        
                                                    }
                                                }

                                                completion(true)
        }
        
        //actionDelete.image = #imageLiteral(resourceName: )
        actionDelete.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [actionDelete])
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.viewModel.selectedContact = viewModel.contactList.object(at: indexPath)
        self.performSegue(withIdentifier: "GoToViewContactView", sender: self)

    }
    
}

extension ContactListTableViewController: NewContactViewControllerDelegate {
    func didFinishAddingContact() {
        self.refreshContactList(self)
    }
}
