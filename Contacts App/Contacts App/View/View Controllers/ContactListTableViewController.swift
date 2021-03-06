//
//  ContactListTableViewController.swift
//  Contacts App
//
//  Created by Anderson Gralha on 19/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit
import CoreData

class ContactListTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    fileprivate var viewModel = ContactListViewModel()
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Outlets
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSearch()
        self.refreshContactList(self)
//        self.setupRefreshControl()
        
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
    private func setupRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshContactList(_:)), for: .valueChanged)
    }
    
    private func setupSearch() {
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.searchBarStyle = .minimal
        navigationItem.searchController = searchController
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? NewContactViewController {
            destination.delegate = self
            
            if segue.identifier == "GoToNewContactView" {
                destination.viewMode = .new
            } else {
                if let contact = viewModel.selectedContact {
                    destination.viewMode = .view
                    destination.viewModel.selectedContact = contact
                }
            }
        }
        
    }
    
    // MARK: Actions
    @IBAction func didPressBookmarksButton(_ sender: Any) {
        searchController.searchBar.showsCancelButton = false
        viewModel.isSearching = false
        viewModel.searchResults = nil
        searchController.searchBar.text = ""
        viewModel.addBookmarks {
            let lastRow = self.tableView.numberOfRows(inSection: 0) - 1
            tableView.reloadData()
        }
    }
    
    @IBAction func didPressNewContactButton(_ sender: Any) {
        self.performSegue(withIdentifier: "GoToNewContactView", sender: self)
    }
    
    // MARK: - Private Functions
    @objc private func refreshContactList(_ sender: Any) {
        self.viewModel.fetchContacts(success: { [weak self] in
            self?.tableView.reloadData()
            self?.refreshControl?.endRefreshing()
        })
    }
    
    // MARK: - Tableview Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.isSearching {
            return viewModel.searchResults?.count ?? 0
        } else {
            return viewModel.contactList?.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListTableViewCellEntry",
                                                       for: indexPath) as? ContactListTableViewCell else {
                                                        return UITableViewCell()
        }
        
        if viewModel.isSearching {
            cell.setup(newContact: viewModel.searchResults?[indexPath.row])
        } else {
            cell.setup(newContact: viewModel.contactList?[indexPath.row])
        }
        
        return cell
    }
    
    // MARK: - Tableview delegate
    override func tableView(_ tableView: UITableView,
                            trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let actionDelete = UIContextualAction(
            style: .destructive,
            title: "Delete") { [weak self] _, _, completion  in
                
                if self?.viewModel.isSearching ?? false {
                
                    Database.shared.removeContact(contact: self?.viewModel.searchResults?[indexPath.row], success: {
                    }, failure: { error in
                    })
                    
                    completion(true)
                    
                } else {
                    
                    Database.shared.removeContact(contact: self?.viewModel.contactList?[indexPath.row], success: {
                    }, failure: { error in
                    })
                    
                    completion(true)
                }
                
        }
        
        actionDelete.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [actionDelete])
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if viewModel.isSearching {
            self.viewModel.selectedContact = viewModel.searchResults?[indexPath.row]
        } else {
            self.viewModel.selectedContact = viewModel.contactList?[indexPath.row]
        }
        self.performSegue(withIdentifier: "GoToViewContactView", sender: self)
        
    }
    
}

// MARK: - New Contact View Controller Delegate
extension ContactListTableViewController: NewContactViewControllerDelegate {
    func didFinishAddingContact() {
        self.refreshContactList(self)
    }
}

// MARK: - Search Bar Delegate
extension ContactListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            viewModel.filterContacts(text: searchText) { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        viewModel.isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        viewModel.isSearching = false
        viewModel.searchResults = nil
        tableView.reloadData()
        searchBar.text = ""
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}
