//
//  CATextField.swift
//  CommonAppleKit
//
//  Created by Roman Podymov on 21/01/2024.
//  Copyright © 2024 CommonAppleKit. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public typealias CATextFieldBaseClass = UITextField
#elseif canImport(AppKit)
import AppKit

public typealias CATextFieldBaseClass = NSTextField
#endif

public class CATextField: CATextFieldBaseClass {
    let inset: CGFloat?

    public init(frame: CGRect = .zero, inset: CGFloat? = nil) {
        self.inset = inset
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        self.inset = nil
        super.init(coder: coder)
    }
    
    #if canImport(UIKit)
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        if let inset {
            return CGRectInset(bounds, inset, inset)
        } else {
            return super.textRect(forBounds: bounds)
        }
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        if let inset {
            return CGRectInset(bounds, inset, inset)
        } else {
            return super.editingRect(forBounds: bounds)
        }
    }

    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        if let inset {
            return CGRectInset(bounds, inset, inset)
        } else {
            return super.placeholderRect(forBounds: bounds)
        }
    }
    #endif
}

#if canImport(UIKit)
    public typealias CASecureTextField = CATextField

    public extension CATextFieldBaseClass {
        var stringValue: String {
            get {
                text ?? ""
            }

            set {
                text = newValue
            }
        }
    }
#elseif canImport(AppKit)
    public class CASecureTextField: NSSecureTextField {
        public init(frame: CGRect = .zero, inset: CGFloat? = nil) {
            super.init(frame: frame)
        }
        
        public required init?(coder: NSCoder) {
            super.init(coder: coder)
        }

        public var isSecureTextEntry: Bool {
            get {
                true
            }

            set {

            }
        }
    }

    public extension CATextFieldBaseClass {
        var placeholder: String {
            set {
                placeholderString = newValue
            }

            get {
                placeholderString ?? ""
            }
        }

        var attributedPlaceholder: NSAttributedString {
            set {
                placeholderAttributedString = newValue
            }

            get {
                placeholderAttributedString ?? .init(string: "")
            }
        }
    }
#endif
