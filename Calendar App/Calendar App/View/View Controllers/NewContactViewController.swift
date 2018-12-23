//
//  NewContactViewController.swift
//  Calendar App
//
//  Created by Anderson Gralha on 19/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit

@objc protocol NewContactViewControllerDelegate: class {
    @objc optional func didFinishAddingContact()
}

class NewContactViewController: BaseViewController {

    // MARK: - Properties

//    let sectionHeaderTitles = ["", "Phone", "Email", "Address"]

    weak var delegate: NewContactViewControllerDelegate?
    
    lazy var viewModel = NewContactViewModel()
    
    var viewMode = EnumNewContactViewModel.new {
        didSet {
            setupLayout()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    // Mark -- UI
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        setupLayout()
        
    }
    
    private func setupLayout() {
        switch viewMode {
        case .new:
            viewModel.setupNewContact()
        case .edit:
            break
        case .view:
            break
        }
    }
    
    // Mark -- Actions
    
    //    @IBAction func didPressCancelButton(_ sender: Any) {
    //        self.navigationController?.dismiss(animated: true, completion: nil)
    //    }
    
    @IBAction func didPressDoneButton(_ sender: Any) {
        viewModel.addContact(success: { 
            delegate?.didFinishAddingContact?()
        }, failure: { [weak self] in
            self?.showAlert(error: $0)
        })
        
        self.navigationController?.popViewController(animated: true)
    }
    
}

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

extension NewContactViewController: UITableViewDataSource {

    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        if section == 1 {
    //            return "Address"
    //        } else if section == 2 {
    //            return "Phone"
    //        } else if section == 3 {
    //            return "Email"
    //        } else {
    //            return ""
    //        }
    //    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return (viewModel.selectedContact?.phones?.count ?? 0) + 1
        } else if section == 2 {
            return (viewModel.selectedContact?.emails?.count ?? 0) + 1
        } else {
            return (viewModel.selectedContact?.addresses?.count ?? 0) + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewContactTableViewCell.mainInformation,
                                                           for: indexPath) as? NewContactTableViewCell else {
                                                            return UITableViewCell()
            }

            cell.delegate = self

            return cell
            
        } else {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewContactTableViewCell.listInformation,
                                                           for: indexPath) as? NewContactTableViewCell else {
                                                            return UITableViewCell()
            }

            cell.indexPath = indexPath
            cell.delegate = self

            let isLastItem = viewModel.isLastItem(indexPath)
            cell.setupListCell(isLastItem: isLastItem)

            if !isLastItem {
                if viewMode == .edit || viewMode == .view {
                    switch indexPath.section {
                    case EnumContactDataSection.phone.rawValue:
                        cell.setupDefaultValue(value: (viewModel.selectedContact?.phones?.allObjects[indexPath.row] as? Phone)?.phone ?? "")
                    case EnumContactDataSection.email.rawValue:
                        cell.setupDefaultValue(value: (viewModel.selectedContact?.emails?.allObjects[indexPath.row] as? Email)?.email ?? "")
                    case EnumContactDataSection.address.rawValue:
                        cell.setupDefaultValue(value: "asdajads")
                    default:
                        break
                    }

                }
            }
            return cell
        }
        
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 20))

        return view
    }

//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 22))
//        let label = UILabel(frame: CGRect(x: 16, y: 0, width: 100, height: 22))
//        view.addSubview(label)
//
//        label.text = sectionHeaderTitles[section]
//        label.font = UIFont.textFieldHeaderFont(ofSize: label.font.pointSize)
//
//        return view
//
//    }
}

extension NewContactViewController: NewContactTableViewDelegate {
    
    func didPressRemoveItem(at indexPath: IndexPath) {
        print("REMOVE: \(indexPath)")
    }

    func didPressAddItem(at indexPath: IndexPath) {
        print("ADD: \(indexPath)")

    }

    func didFinishFillingData(data: EnumDataField?, value: Any) {
        guard let data = data else {
            return
        }
        print(value)
        print(data)

        switch data {
        case .firstName:
            if let value = value as? String {
                self.viewModel.selectedContact?.firstName = value
            }
        case .lastName:
            if let value = value as? String {
                self.viewModel.selectedContact?.lastName = value
            }
        case .birthday:
            break
        case .address(let index):
            break
        case .phone(let index):
            if let value = value as? String,
                let phones = self.viewModel.selectedContact?.phones?.allObjects as? [Phone] {
                phones[index].phone = value
            }
        case .email(let index):
            if let value = value as? String,
                let emails = self.viewModel.selectedContact?.emails?.allObjects as? [Email] {
                emails[index].email = value
            }
        }
    }
}
