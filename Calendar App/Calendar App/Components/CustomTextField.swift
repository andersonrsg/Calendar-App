////
////  CustomTextField.swift
////  Calendar App
////
////  Created by Anderson Gralha on 20/12/18.
////  Copyright © 2018 andersongralha. All rights reserved.
////
//
//import UIKit
//
//@IBDesignable class CustomTextField: UITextField {
//    
//    let animationDuration = 0.3
//    var title = UILabel()
//    var errorLabel = UILabel()
//    var underline = UIView()
//    
//    let errorColor: UIColor = UIColor(displayP3Red: 255/255, green: 7/255, blue: 24/255, alpha: 1)
//    let defaultColor: UIColor = UIColor(displayP3Red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
//    
//    let placeholderColor: UIColor = UIColor(displayP3Red: 21/255, green: 21/255, blue: 21/255, alpha: 0.6)
//    
//    let placeholderUpErrorColor: UIColor = UIColor(displayP3Red: 255/255, green: 7/255, blue: 24/255, alpha: 1)
//    
//    var textFont =  UIFont.textFieldFont(ofSize: 14)
//    let placeHolderFont = UIFont.textFieldPlaceHolder(ofSize: 12)
//    
//    private var hasError = false
//    
//    var activityIndicatorView: UIActivityIndicatorView?
//    
//    // MARK: - Properties
//    override var accessibilityLabel: String? {
//        get {
//            if let txt = text, txt.isEmpty {
//                return title.text
//            } else {
//                return text
//            }
//        }
//        set {
//            self.accessibilityLabel = newValue
//        }
//    }
//    
//    override var placeholder: String? {
//        didSet {
//            title.text = placeholder
//            title.sizeToFit()
//        }
//    }
//    
//    override var attributedPlaceholder: NSAttributedString? {
//        didSet {
//            title.text = attributedPlaceholder?.string
//            title.sizeToFit()
//        }
//    }
//    
//    @IBInspectable var hintYPadding: CGFloat = 0.0
//    
//    @IBInspectable var titleYPadding: CGFloat = -2.2 {
//        didSet {
//            var frame = title.frame
//            frame.origin.y = titleYPadding
//            title.frame = frame
//        }
//    }
//    
//    @IBInspectable var paddindLeft: CGFloat = 0.0 {
//        didSet {
//            padding = UIEdgeInsets(top: paddindTop, left: paddindLeft, bottom: paddindBottom, right: paddindRight)
//        }
//    }
//    
//    @IBInspectable var paddindRight: CGFloat = 0.0 {
//        didSet {
//            padding = UIEdgeInsets(top: paddindTop, left: paddindLeft, bottom: paddindBottom, right: paddindRight)
//        }
//    }
//    
//    @IBInspectable var paddindTop: CGFloat = 0.0 {
//        didSet {
//            padding = UIEdgeInsets(top: paddindTop, left: paddindLeft, bottom: paddindBottom, right: paddindRight)
//        }
//    }
//    
//    @IBInspectable var paddindBottom: CGFloat = 0.0 {
//        didSet {
//            padding = UIEdgeInsets(top: paddindTop, left: paddindLeft, bottom: paddindBottom, right: paddindRight)
//        }
//    }
//    
//    @IBInspectable var showBorder: Bool = true {
//        didSet {
//            if !showBorder {
//                removeBorder()
//            }
//        }
//    }
//    
//    @IBInspectable var customFontSize: Bool = false {
//        didSet {
//            setup()
//        }
//    }
//    
//    @IBInspectable var addBlackArrow: Bool = false {
//        didSet {
//            let arrowImage = UIImage(named: "blackArrow")
//            self.rightViewMode = .always
//            self.rightView = UIImageView(image: arrowImage)
//        }
//    }
//    
//    private var padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
//    
//    private let padding2 = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 5)
//    
//    // MARK: - Init
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setup()
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//    
//    // MARK: - Overrides
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        setTitlePositionForTextAlignment()
//        
//        let isResp = isFirstResponder
//        if let txt = text, !txt.isEmpty && isResp {
//            title.textColor = defaultColor
//            underline.backgroundColor = defaultColor
//            errorLabel.alpha = 0
//        } else {
//            title.textColor = placeholderColor
//            underline.backgroundColor = defaultColor
//            errorLabel.alpha = 0 
//        }
//        // Should we show or hide the title label?
//        if let txt = text, txt.isEmpty {
//            // Hide
//            hideTitle(isResp)
//        } else {
//            // Show
//            showTitle(isResp)
//        }
//        
//        errorLabel.frame = CGRect(x: 0,
//                                  y: self.frame.size.height + 5,
//                                  width: self.frame.size.width,
//                                  height: 20)
//        errorLabel.font = textFont
//        
//        underline.frame = CGRect(x: 0,
//                                 y: self.frame.size.height,
//                                 width: self.frame.size.width,
//                                 height: 2)
//        underline.backgroundColor = defaultColor
//        self.addSubview(underline)
//        
//        if hasError {
//            setError()
//        } else {
//            setDefault()
//        }
//
//    }
//    
//    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding2)
//    }
//    
//    override open func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding2)
//    }
//    
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
//    
//    // MARK: - Public Methods
//    
//    func showActivityIndicatorView() {
//        if activityIndicatorView == nil {
//            self.activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//            self.activityIndicatorView?.startAnimating()
//            self.activityIndicatorView?.style = .gray
//        }
//        self.rightViewMode = .always
//        self.rightView = self.activityIndicatorView
//    }
//    
//    func dismissActivityIndicatorView() {
//        self.rightViewMode = .never
//        self.rightView = nil
//    }
//    
//    func setErrorMessage(_ message: String) {
//        errorLabel.text = message
//    }
//    
//    func setError() {
//        UIView.animate(withDuration: 0.3,
//                       delay: 0,
//                       options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.curveEaseOut],
//                       animations: {
//        
//                        self.underline.backgroundColor = self.errorColor
//                        self.title.textColor = self.placeholderUpErrorColor
//                        self.errorLabel.alpha = 1
//                        self.hasError = true
//        }, completion: nil)
//    }
//    
//    func setDefault() {
//        UIView.animate(withDuration: 0.3,
//                       delay: 0,
//                       options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.curveEaseOut],
//                       animations: {
//        
//                        self.underline.backgroundColor = self.defaultColor
//                        self.title.textColor = self.placeholderColor
//                        self.errorLabel.alpha = 0
//                        self.hasError = false
//        }, completion: nil)
//        
//    }
//    
//    func removeBorder() {
//        underline.isHidden = true
//    }
//    
//    // MARK: - Private Methods
//    fileprivate func setup() {
//
//        if customFontSize {
//            textFont = UIFont.textFieldFont(ofSize: self.font?.pointSize ?? 14)
//            self.font = textFont
//        }
//        
//        borderStyle = UITextField.BorderStyle.none
//        //titleActiveTextColour = tintColor
//        
//        // Set up title label
//        title.alpha = 0.0
//        title.font = placeHolderFont
//        title.sizeToFit()
//        title.textColor = defaultColor
//        //titleActiveTextColour = defaultColor
//        
//        // Setup textFont
//        font = textFont
//        
//        if let str = placeholder, !str.isEmpty {
//            title.text = str
//            title.sizeToFit()
//        }
//        self.addSubview(title)
//        
//        // Setup Error Label
//        //        errorLabel.alpha = 0.0
//        errorLabel.font = placeHolderFont
//        errorLabel.sizeToFit()
//        errorLabel.textColor = errorColor
//        self.addSubview(errorLabel)
//    }
//    
//    fileprivate func maxTopInset() -> CGFloat {
//        if let fnt = font {
//            return max(0, floor(bounds.size.height - fnt.lineHeight - 4.0))
//        }
//        return 0
//    }
//    
//    fileprivate func setTitlePositionForTextAlignment() {
//        //        let rect = textRect(forBounds: bounds)
//        //        var xv = rect.origin.x
//        //        if textAlignment == NSTextAlignment.center {
//        //            xv = rect.origin.x + (rect.size.width * 0.5) - title.frame.size.width
//        //        } else if textAlignment == NSTextAlignment.right {
//        //            xv = rect.origin.x + rect.size.width - title.frame.size.width
//        //        }
//        title.frame = CGRect(x: 0,
//                             y: title.frame.origin.y,
//                             width: title.frame.size.width,
//                             height: title.frame.size.height)
//    }
//    
//    fileprivate func showTitle(_ animated: Bool) {
//        let dur = animated ? animationDuration :  0
//        UIView.animate(withDuration: dur,
//                       delay: 0,
//                       options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.curveEaseOut],
//                       animations: {
//                        // Animation
//                        self.title.alpha = 1.0
//                        var frame = self.title.frame
//                        frame.origin.y = self.titleYPadding
//                        self.title.frame = frame
//        }, completion: nil)
//    }
//    
//    fileprivate func hideTitle(_ animated: Bool) {
//        let dur = animated ? animationDuration :  0
//        UIView.animate(withDuration: dur,
//                       delay: 0,
//                       options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.curveEaseIn],
//                       animations: {
//                        // Animation
//                        self.title.alpha = 0.0
//                        var frame = self.title.frame
//                        frame.origin.y = self.title.font.lineHeight + self.hintYPadding
//                        self.title.frame = frame
//        }, completion: nil)
//    }
//}
