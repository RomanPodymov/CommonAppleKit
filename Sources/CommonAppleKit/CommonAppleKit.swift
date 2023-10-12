//
//  CommonAppleKit.swift
//  CommonAppleKit
//
//  Created by Roman Podymov on 12/10/2023.
//  Copyright © 2023 CommonAppleKit. All rights reserved.
//

#if canImport(UIKit)
    import UIKit

    typealias ViewController = UIViewController
    typealias ApplicationDelegate = UIApplicationDelegate
    typealias AppDelegateBaseClass = UIResponder
    typealias TabBarController = UITabBarController
    typealias Button = UIButton
    typealias TextField = UITextField

    extension TextField {
        var stringValue: String {
            text ?? ""
        }
    }

    extension Button {
        func addTargetForPrimaryActionTriggered(
            _ target: AnyObject,
            action: Selector
        ) {
            addTarget(target, action: action, for: .primaryActionTriggered)
        }
    }

#elseif canImport(AppKit)
    import AppKit

    typealias ViewController = NSViewController
    typealias ApplicationDelegate = NSApplicationDelegate
    typealias AppDelegateBaseClass = NSObject
    typealias TabBarController = NSTabViewController
    typealias Button = NSButton
    typealias TextField = NSTextField

    extension Button {
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
#endif
