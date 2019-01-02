//
//  NewContactViewController.swift
//  Contacts App
//
//  Created by Anderson Gralha on 19/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit
import CoreData

// MARK: - View Protocol
@objc protocol NewContactViewControllerDelegate: class {
    @objc func didFinishAddingContact()
}

class NewContactViewController: BaseViewController {
    
    // MARK: - Properties
    weak var delegate: NewContactViewControllerDelegate?
    
    lazy var viewModel = NewContactViewModel()
    
    var viewMode = EnumNewContactViewModel.new {
        didSet {
            setupLayout()
        }
    }
    
    // Used to add focus on the text field after table view reload
    fileprivate var selectedRow: IndexPath?
    // Used to show actions options on the cell such as call or send email.
    fileprivate var showActionOption: Bool = false
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var completeButton: UIBarButtonItem!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        setupBackButton()
    }
    
    // MARK: - UI
    private func setupLayout() {
        switch viewMode {
        case .new:
            viewModel.setupNewContact()
        case .edit:
            break
        case .view:
            self.title = ""
            self.showActionOption = true
        }
    }
    
    // MARK: - Private Functions
    private func setupBackButton() {
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(title: "Cancel",
                                         style: .plain,
                                         target: self,
                                         action: #selector(didPressBackButton))
        
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    // MARK: - Actions
    @objc func didPressBackButton(_ sender: Any) {
        delegate?.didFinishAddingContact()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didPressDoneButton(_ sender: Any) {
        self.view.endEditing(true)
        
        viewModel.isValidContact(success: {
            
            viewModel.addContact(success: {
                delegate?.didFinishAddingContact()
            }, failure: { [weak self] in
                self?.showAlert(error: $0)
            })
            
            self.navigationController?.popViewController(animated: true)
            
        }, error: { error in
            
            self.showAlert(title: "Error", error: error)
            
        })
        
    }
}

// MARK: - Table View Delegate
extension NewContactViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return NewContactTableViewCell.mainInformationSize
        } else {
            return NewContactTableViewCell.listInformationSize
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return NewContactTableViewCell.separatorSize
    }
}

// MARK: - Table View Data Source
extension NewContactViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == EnumContactDataSection.primary.rawValue {
            return 1
        } else if section == EnumContactDataSection.phone.rawValue {
            return (viewModel.selectedContact?.phones.count ?? 0) + 1
        } else if section == EnumContactDataSection.email.rawValue {
            return (viewModel.selectedContact?.emails.count ?? 0) + 1
        } else {
            return (viewModel.selectedContact?.addresses.count ?? 0) + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewContactTableViewCell.mainInformation,
                                                           for: indexPath) as? NewContactTableViewCell else {
                                                            return UITableViewCell()
            }
            
            cell.indexPath = indexPath
            cell.delegate = self
            cell.setupMainInformation(defaultValue: self.viewModel.selectedContact)
            
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewContactTableViewCell.listInformation,
                                                           for: indexPath) as? NewContactTableViewCell else {
                                                            return UITableViewCell()
            }
            
            cell.indexPath = indexPath
            cell.delegate = self
            
            let isLastItem = viewModel.isLastItem(indexPath)
            cell.setupListCell(isLastItem: isLastItem, showActionOption: showActionOption)
            
            if !isLastItem {
                if viewMode == .edit || viewMode == .view {
                    switch indexPath.section {
                    case EnumContactDataSection.phone.rawValue:
                        cell.setupDefaultValue(value:
                            (viewModel.selectedContact?.phones[indexPath.row])?.phone ?? "")
                        
                    case EnumContactDataSection.email.rawValue:
                        cell.setupDefaultValue(value:
                            (viewModel.selectedContact?.emails[indexPath.row])?.email ?? "")
                        
                    case EnumContactDataSection.address.rawValue:
                        cell.setupDefaultValue(value:
                            (viewModel.selectedContact?.addresses[indexPath.row])?.address ?? "")
                        
                    default:
                        break
                    }
                    
                }
            }
            
            if let _ = selectedRow {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    cell.dataTextField.becomeFirstResponder()
                    self.selectedRow = nil
                }
            }
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 20))
        return view
    }
    
}

// MARK: - New Contact View Delegate
extension NewContactViewController: NewContactTableViewDelegate {
    
    func didPressRemoveItem(at indexPath: IndexPath) {
        print("REMOVE: \(indexPath)")
        
        self.viewModel.removeItem(for: indexPath)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        // Fully reloads the table view to avoid weird behavior with the stored data
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.tableView.reloadData()
        }
        
    }
    
    func didPressAddItem(at indexPath: IndexPath) {
        print("ADD: \(indexPath)")
        
        if indexPath.section != 0 {
            if viewModel.isLastItem(indexPath) {
                // Adds the new index path adter the selected row
                let newIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
                viewModel.addRow(for: newIndexPath, update: viewMode == .new ? false : true)
                
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                
                // Reload Icons
                tableView.reloadRows(at: [indexPath, newIndexPath], with: .automatic)
                
                // Reload selected row again to make it become first responder
                selectedRow = indexPath
                tableView.reloadRows(at: [indexPath], with: .automatic)
                
            }
        }
    }
    
    func didFinishFillingData(data: EnumDataField?, value: Any?) {
        guard let data = data, let value = value else {
            return
        }
        
        switch data {
        case .firstName:
            if let value = value as? String {
                viewModel.setFirstName(value)
            }
            
        case .lastName:
            if let value = value as? String {
                viewModel.setLastName(value)
            }
            
        case .birthday:
            if let value = value as? Date {
                viewModel.setBirthDate(value)
            }
            
        case .address(let index):
            if let value = value as? String {
                viewModel.setAddress(value, forIndex: index)
            }
            
        case .phone(let index):
            if let value = value as? String {
                viewModel.setPhone(value, forIndex: index)
            }
            
        case .email(let index):
            if let value = value as? String {
                viewModel.setEmail(value, forIndex: index)
            }
            
        }
    }
}
