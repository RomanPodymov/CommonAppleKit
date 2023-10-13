//
//  CommonAppleKit.swift
//  CommonAppleKit
//
//  Created by Roman Podymov on 12/10/2023.
//  Copyright © 2023 CommonAppleKit. All rights reserved.
//

#if canImport(UIKit)
    import UIKit

    public typealias ViewController = UIViewController
    public typealias ApplicationDelegate = UIApplicationDelegate
    public typealias AppDelegateBaseClass = UIResponder
    public typealias TabBarController = UITabBarController
    public typealias Button = UIButton
    public typealias TextField = UITextField

    public extension TextField {
        var stringValue: String {
            text ?? ""
        }
    }

    public extension Button {
        func addTargetForPrimaryActionTriggered(
            _ target: AnyObject,
            action: Selector
        ) {
            addTarget(target, action: action, for: .primaryActionTriggered)
        }
    }

#elseif canImport(AppKit)
    import AppKit

    public typealias ViewController = NSViewController
    public typealias ApplicationDelegate = NSApplicationDelegate
    public typealias AppDelegateBaseClass = NSObject
    public typealias TabBarController = NSTabViewController
    public typealias Button = NSButton
    public typealias TextField = NSTextField

    public extension Button {
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

    public extension TabBarController {
        var viewControllers: [ViewController] {
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
