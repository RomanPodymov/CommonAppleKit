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
    let inset: CGFloat = 10

    #if canImport(UIKit)
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, inset, inset)
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, inset, inset)
    }

    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, inset, inset) 
    }
    #endif
}

#if canImport(UIKit)
    public typealias CASecureTextField = CATextField

    public extension CATextField {
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
    public class CASecureTextField: NSSecureTextField { }

    public extension CATextField {
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
