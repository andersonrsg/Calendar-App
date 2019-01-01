//
//  NewContactTableViewCell.swift
//  Contacts App
//
//  Created by Anderson Gralha on 20/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit

protocol NewContactTableViewDelegate: class {
    func didFinishFillingData(data: EnumDataField?, value: Any?)
    func didPressRemoveItem(at indexPath: IndexPath)
    func didPressAddItem(at indexPath: IndexPath)
}

class NewContactTableViewCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    lazy var viewModel = NewContactTableViewCellViewModel()
    
    weak var delegate: NewContactTableViewDelegate?
    
    private var birthdayPickerView: UIDatePicker?
    
    private var tapGestureRecognizer: UITapGestureRecognizer!
    
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
        return 60
    }
    
    // Section separator size
    class var separatorSize: CGFloat {
        return 20
    }
    
    override var indexPath: IndexPath? {
        didSet {
            if let indexPath = indexPath {
                currentDataType = EnumContactDataSection(rawValue: indexPath.section)
                switch indexPath.section {
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
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Public Functions
    func setupMainInformation(defaultValue: RContact?) {
        super.setup()
        
        guard let contact = defaultValue else {
            return
        }
        
        firstNameTextField.text = contact.firstName
        lastNameTextField.text = contact.lastName
        birthDayTextField.text = contact.dateOfBirth?.formatDateUS()
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        birthDayTextField.delegate = self
        
        setupPicker()
    }
    
    func setupDefaultValue(value: String) {
        self.dataTextField.text = value
    }
    
    func setupListCell(isLastItem: Bool, showActionOption: Bool) {
        super.setup()
        
        guard let indexPath = indexPath else {
            return
        }
        
        dataTextField.delegate = self
        
        // Setup gesture for add and remove icons
        
        if isLastItem {
            dataTextField.addLeftView(image: viewModel.iconAdd)
            (dataTextField.leftView as? UIImageView)?.tintColor = UIColor.ImageTintColors.addNewDataColor
            
            tapGestureRecognizer = UITapGestureRecognizer(
                target: self,
                action: #selector(addItem(tapGestureRecognizer:)))
            
        } else {
            dataTextField.addLeftView(image: viewModel.iconRemove)
            (dataTextField.leftView as? UIImageView)?.tintColor = UIColor.ImageTintColors.removeDataColor
            
            tapGestureRecognizer = UITapGestureRecognizer(
                target: self,
                action: #selector(removeItem(tapGestureRecognizer:)))
            
        }
        dataTextField.leftView?.isUserInteractionEnabled = true
        dataTextField.leftView?.addGestureRecognizer(tapGestureRecognizer)
        
        // Setup current data text field
        dataTextField.placeholder = viewModel.placeHolderList[indexPath.section]
        dataTextField.keyboardType = viewModel.keyboardTypeList[indexPath.section]
        dataTextField.textContentType = viewModel.keyboardContentTypeList[indexPath.section]
        
        if showActionOption && !isLastItem {
            if indexPath.section == EnumContactDataSection.phone.rawValue ||
                indexPath.section == EnumContactDataSection.email.rawValue {
                
                dataTextField.addRightView(image: viewModel.itemActionList[indexPath.section])
                (dataTextField.rightView as? UIImageView)?.tintColor = viewModel.itemActionColors[indexPath.section]
                
                addAction()
                
            }
        }
        
    }
    
    // MARK: - Private Functions
    
    private func addAction() {
        let actionGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(performAction(tapGestureRecognizer:)))
        
        dataTextField.rightView?.isUserInteractionEnabled = true
        dataTextField.rightView?.addGestureRecognizer(actionGestureRecognizer)
    }
    
    @objc private func performAction(tapGestureRecognizer: UITapGestureRecognizer) {
        
        switch indexPath?.section {
        case EnumContactDataSection.phone.rawValue:
            
            if let phone = dataTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
                if let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
            
        case EnumContactDataSection.email.rawValue:
            
            if let email = dataTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
                if let url = URL(string: "mailto:\(email)"), UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
            
        default:
            break
        }
        
    }
    
    @objc private func removeItem(tapGestureRecognizer: UITapGestureRecognizer) {
        guard let indexPath = indexPath else {
            return
        }
        // Pauses gesture recognizer action to avoid crashing
        tapGestureRecognizer.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            tapGestureRecognizer.isEnabled = true
        }
        
        self.dataTextField.resignFirstResponder()
        delegate?.didPressRemoveItem(at: indexPath)
        
    }
    
    @objc private func addItem(tapGestureRecognizer: UITapGestureRecognizer) {
        guard let indexPath = indexPath else {
            return
        }
        delegate?.didPressAddItem(at: indexPath)
    }
    
    // MARK: - UI
    private func setupPicker() {
        birthdayPickerView = UIDatePicker()
        birthdayPickerView?.datePickerMode = .date
        birthDayTextField.inputView = birthdayPickerView
        birthdayPickerView?.addTarget(self,
                                      action: #selector(pickerDateDidChange),
                                      for: .valueChanged)
        
    }
    
    // MARK: - Actions
    @objc fileprivate func pickerDateDidChange(sender: UIDatePicker?) {
        birthDayTextField.text = sender?.date.formatDateUS()
    }
    
}

// MARK: - Text Field Delegate
extension NewContactTableViewCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        guard let text = textField.text, let indexPath = indexPath else {
            return
        }
        
        if text != "" {
            
            if indexPath.section == 0 {
                switch textField.tag {
                case 0:
                    currentDataField = .firstName
                case 1:
                    currentDataField = .lastName
                case 2:
                    currentDataField = .birthday
                    delegate?.didFinishFillingData(data: self.currentDataField, value: birthdayPickerView?.date)
                    return
                default:
                    break
                }
                delegate?.didFinishFillingData(data: self.currentDataField, value: text)
            } else {
                delegate?.didFinishFillingData(data: self.currentDataField, value: text)
            }
            
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        guard let indexPath = indexPath else {
            return
        }
        
        delegate?.didPressAddItem(at: indexPath)
    }
    
}
