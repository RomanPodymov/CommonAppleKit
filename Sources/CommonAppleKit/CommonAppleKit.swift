//
//  CommonAppleKit.swift
//  CommonAppleKit
//
//  Created by Roman Podymov on 12/10/2023.
//  Copyright © 2023 CommonAppleKit. All rights reserved.
//

#if canImport(UIKit)
    import UIKit

    public typealias CAViewController = UIViewController
    public typealias CAApplicationDelegate = UIApplicationDelegate
    public typealias CAAppDelegateBaseClass = UIResponder
    public typealias CATabBarController = UITabBarController
    public typealias CAButton = UIButton
    public typealias CATextField = UITextField
    public typealias CAImage = UIImage

    public extension CATextField {
        var stringValue: String {
            text ?? ""
        }
    }

    public extension CAButton {
        func addTargetForPrimaryActionTriggered(
            _ target: AnyObject,
            action: Selector
        ) {
            addTarget(target, action: action, for: .primaryActionTriggered)
        }
    }

#elseif canImport(AppKit)
    import AppKit

    public typealias CAViewController = NSViewController
    public typealias CAApplicationDelegate = NSApplicationDelegate
    public typealias CAAppDelegateBaseClass = NSObject
    public typealias CATabBarController = NSTabViewController
    public typealias CAButton = NSButton
    public typealias CATextField = NSTextField
    public typealias CAImage = NSImage

    public extension CAImage {
        @available(macOS 11.0, *)
        convenience init?(systemName: String) {
            self.init(systemSymbolName: systemName, accessibilityDescription: nil)
        }
    }

    public extension CAButton {
        func setTitleForAllStates(_ title: String) {
            self.title = title
        }

        func addTargetForPrimaryActionTriggered(
            _ target: AnyObject,
            action: Selector
        ) {
            self.target = target
            self.action = action
        }
    }

    public extension CATabBarController {
        var viewControllers: [CAViewController] {
            get {
                tabViewItems.compactMap(\.viewController)
            }

            set {
                tabViewItems = newValue.map {
                    .init(viewController: $0)
                }
            }
        }
    }
#endif
