//
//  CustomTextField.swift
//  Contacts App
//
//  Created by Anderson Gralha on 20/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit

@IBDesignable class CustomTextField: UITextField {

    // MARK: - Properties
    private let animationDuration = 0.3
    
    private var underline = UIView()

    private let errorColor: UIColor = UIColor(displayP3Red: 255/255, green: 7/255, blue: 24/255, alpha: 0.8)
    private let defaultColor: UIColor = UIColor(displayP3Red: 33/255, green: 33/255, blue: 33/255, alpha: 0.3)

    private var textFont =  UIFont.textFieldFont(ofSize: 14)

    private var hasError = false

    @IBInspectable var hintYPadding: CGFloat = 0.0

    @IBInspectable var paddindLeft: CGFloat = 0.0 {
        didSet {
            padding = UIEdgeInsets(top: paddindTop, left: paddindLeft, bottom: paddindBottom, right: paddindRight)
        }
    }

    @IBInspectable var paddindRight: CGFloat = 0.0 {
        didSet {
            padding = UIEdgeInsets(top: paddindTop, left: paddindLeft, bottom: paddindBottom, right: paddindRight)
        }
    }

    @IBInspectable var paddindTop: CGFloat = 0.0 {
        didSet {
            padding = UIEdgeInsets(top: paddindTop, left: paddindLeft, bottom: paddindBottom, right: paddindRight)
        }
    }

    @IBInspectable var paddindBottom: CGFloat = 0.0 {
        didSet {
            padding = UIEdgeInsets(top: paddindTop, left: paddindLeft, bottom: paddindBottom, right: paddindRight)
        }
    }

    @IBInspectable var showBorder: Bool = true {
        didSet {
            if !showBorder {
                removeBorder()
            }
        }
    }

    @IBInspectable var customFontSize: Bool = false {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var defaultPadding: Bool = true {
        didSet {
            if !defaultPadding {
                padding = customPadding
            }
        }
    }

    private var padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
    private var customPadding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 5)

    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    // MARK: - Overrides
    override func layoutSubviews() {
        super.layoutSubviews()

        let isResp = isFirstResponder
        if let txt = text, !txt.isEmpty && isResp {
            underline.backgroundColor = defaultColor
        } else {
            underline.backgroundColor = defaultColor
        }

        underline.frame = CGRect(x: 0,
                                 y: self.frame.size.height,
                                 width: self.frame.size.width,
                                 height: 1)
        underline.backgroundColor = defaultColor
        self.addSubview(underline)

        if hasError {
            setError()
        } else {
            setDefault()
        }

    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    // MARK: - Public Methods
    func setError() {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.curveEaseOut],
                       animations: {

                        self.underline.backgroundColor = self.errorColor
                        self.hasError = true
        }, completion: nil)
    }

    func setDefault() {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.curveEaseOut],
                       animations: {

                        self.underline.backgroundColor = self.defaultColor
                        self.hasError = false
        }, completion: nil)

    }

    func removeBorder() {
        underline.isHidden = true
    }

    // MARK: - Private Methods
    fileprivate func setup() {

        if customFontSize {
            textFont = UIFont.textFieldFont(ofSize: self.font?.pointSize ?? 14)
            self.font = textFont
        }

        borderStyle = UITextField.BorderStyle.none

        font = textFont

    }

    fileprivate func maxTopInset() -> CGFloat {
        if let fnt = font {
            return max(0, floor(bounds.size.height - fnt.lineHeight - 4.0))
        }
        return 0
    }

}
