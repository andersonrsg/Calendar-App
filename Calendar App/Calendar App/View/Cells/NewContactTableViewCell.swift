//
//  NewContactTableViewCell.swift
//  Calendar App
//
//  Created by Anderson Gralha on 20/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit

protocol NewContactTableViewDelegate: class {
    func didFinishFillingData(data: EnumDataField?, value: Any)
    func didPressRemoveItem(at indexPath: IndexPath)
    func didPressAddItem(at indexPath: IndexPath)
}

class NewContactTableViewCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    lazy var viewModel = NewContactTableViewCellViewModel()
    
    weak var delegate: NewContactTableViewDelegate?
    
    class var mainInformation: String {
        return "NewContactTableViewCellMainInformation"
    }
    
    class var listInformation: String {
        return "NewContactTableViewCellListInformation"
    }
    
    class var mainInformationSize: CGFloat {
        return 150
    }
    
    class var listInformationSize: CGFloat {
        return 70
    }
    
    class var separatorSize: CGFloat {
        return 20
    }
    
    override var indexPath: IndexPath? {
        didSet {
            if let indexPath = indexPath {
                currentDataType = EnumContactDataSection(rawValue: indexPath.section ?? 0)
                switch indexPath.section {
                case 0:
                    switch indexPath.row {
                    case 0:
                        currentDataField = .firstName
                    case 1:
                        currentDataField = .lastName
                    case 2:
                        currentDataField = .birthday
                    default:
                        break
                    }
                case 1:
                    currentDataField = .phone(index: indexPath.row)
                case 2:
                    currentDataField = .email(index: indexPath.row)
                case 3:
                    currentDataField = .address(index: indexPath.row)
                default:
                    break
                }
            }
        }
        
    }
    
    
    // Used for better management of sections and current data being worked
    var currentDataType: EnumContactDataSection!
    var currentDataField: EnumDataField!
    
    // MARK: - Outlets
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var birthDayTextField: UITextField!
    
    @IBOutlet weak var dataTextField: UITextField!
    
    // MARK: -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupMainInformation() {
        super.setup()
        
    }
    
    // MARK: - Actions
    func setupDefaultValue(value: String) {
        self.dataTextField.text = value
    }
    
    func setupListCell(isLastItem: Bool) {
        super.setup()
        
        guard let indexPath = indexPath else {
            return
        }
        
        dataTextField.delegate = self
        
        // Setup gesture for add and remove icons
        let tapGestureRecognizer: UITapGestureRecognizer!
        
        if isLastItem {
            dataTextField.addLeftView(image: viewModel.iconAdd)
            (dataTextField.leftView as? UIImageView)?.tintColor = UIColor.green
            
            tapGestureRecognizer = UITapGestureRecognizer(
                target: self,
                action: #selector(addItem(tapGestureRecognizer:)))
            
        } else {
            dataTextField.addLeftView(image: viewModel.iconRemove)
            (dataTextField.leftView as? UIImageView)?.tintColor = UIColor.red
            
            tapGestureRecognizer = UITapGestureRecognizer(
                target: self,
                action: #selector(removeItem(tapGestureRecognizer:)))
            
        }
        dataTextField.leftView?.isUserInteractionEnabled = true
        dataTextField.leftView?.addGestureRecognizer(tapGestureRecognizer)
        
        // Setup current data field
        //        currentDataField = EnumDataField(rawValue: indexPath.section)
    }
    
    @objc func removeItem(tapGestureRecognizer: UITapGestureRecognizer) {
        guard let indexPath = indexPath else {
            return
        }
        delegate?.didPressRemoveItem(at: indexPath)
    }
    
    @objc func addItem(tapGestureRecognizer: UITapGestureRecognizer) {
        guard let indexPath = indexPath else {
            return
        }
        delegate?.didPressAddItem(at: indexPath)
    }
}

extension NewContactTableViewCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        guard let text = textField.text, let indexPath = indexPath else {
            return
        }
        
        if text != "" {
            
            if indexPath.section == 0 {
                delegate?.didFinishFillingData(data: self.currentDataField, value: text)
            } else {
                delegate?.didFinishFillingData(data: self.currentDataField, value: text)
            }
            
            
            
        }
    }
}
