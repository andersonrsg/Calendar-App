//
//  CustomTextField.swift
//  Calendar App
//
//  Created by Anderson Gralha on 20/12/18.
//  Copyright © 2018 andersongralha. All rights reserved.
//

import UIKit

@IBDesignable class CustomTextField: UITextField {

    let animationDuration = 0.3
    var underline = UIView()

    let errorColor: UIColor = UIColor(displayP3Red: 255/255, green: 7/255, blue: 24/255, alpha: 0.8)
    let defaultColor: UIColor = UIColor(displayP3Red: 33/255, green: 33/255, blue: 33/255, alpha: 0.3)

    var textFont =  UIFont.textFieldFont(ofSize: 14)

    private var hasError = false

    var activityIndicatorView: UIActivityIndicatorView?

    // MARK: - Properties

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

    private var padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 5)

//    private let padding2 = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 5)

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

//    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
//        var rect = super.clearButtonRect(forBounds: bounds)
//        if let txt = text, !txt.isEmpty {
//            var top = ceil(title.font.lineHeight + hintYPadding)
//            top = min(top, maxTopInset())
//            rect = CGRect(x: rect.origin.x,
//                          y: rect.origin.y + (top * 0.5),
//                          width: rect.size.width,
//                          height: rect.size.height)
//        }
//        return rect.integral
//    }

    // MARK: - Public Methods

    func showActivityIndicatorView() {
        if activityIndicatorView == nil {
            self.activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            self.activityIndicatorView?.startAnimating()
            self.activityIndicatorView?.style = .gray
        }
        self.rightViewMode = .always
        self.rightView = self.activityIndicatorView
    }

    func dismissActivityIndicatorView() {
        self.rightViewMode = .never
        self.rightView = nil
    }

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
