//
//  CommonAppleKit.swift
//  CommonAppleKit
//
//  Created by Roman Podymov on 12/10/2023.
//  Copyright © 2023 CommonAppleKit. All rights reserved.
//

#if canImport(UIKit)
    import UIKit

    public typealias CAView = UIView
    public typealias CAViewController = UIViewController
    public typealias CAApplicationDelegate = UIApplicationDelegate
    public typealias CAAppDelegateBaseClass = UIResponder
    public typealias CATabBarController = UITabBarController
    public typealias CAButton = UIButton
    public typealias CATextField = UITextField
    public typealias CAImage = UIImage
    public typealias CAScrollView = UIScrollView
    public typealias CACollectionView = UICollectionView
    public typealias CACollectionViewCell = UICollectionViewCell
    public typealias CALabel = UILabel
    public typealias CACollectionViewDataSource = UICollectionViewDataSource
    public typealias CACollectionViewDelegate = UICollectionViewDelegate
    public typealias CACollectionViewDelegateFlowLayout = UICollectionViewDelegateFlowLayout
    public typealias CACollectionViewLayout = UICollectionViewLayout
    public typealias CACollectionViewFlowLayout = UICollectionViewFlowLayout
    public typealias CAColor = UIColor

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

        func actions(for target: Any) -> [String] {
            actions(forTarget: target, forControlEvent: .primaryActionTriggered) ?? []
        }
    }

#elseif canImport(AppKit)
    import AppKit

    public typealias CAView = NSView
    public typealias CAViewController = NSViewController
    public typealias CAApplicationDelegate = NSApplicationDelegate
    public typealias CAAppDelegateBaseClass = NSObject
    public typealias CATabBarController = NSTabViewController
    public typealias CAButton = NSButton
    public typealias CATextField = NSTextField
    public typealias CAImage = NSImage
    public typealias CAScrollView = NSScrollView
    public typealias CACollectionView = NSCollectionView
    public typealias CACollectionViewCell = NSCollectionViewItem
    public typealias CALabel = NSTextField
    public typealias CACollectionViewDataSource = NSCollectionViewDataSource
    public typealias CACollectionViewDelegate = NSCollectionViewDelegate
    public typealias CACollectionViewDelegateFlowLayout = NSCollectionViewDelegateFlowLayout
    public typealias CACollectionViewLayout = NSCollectionViewLayout
    public typealias CACollectionViewFlowLayout = NSCollectionViewFlowLayout
    public typealias CAColor = NSColor

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

        func actions(for target: Any) -> [String] {
            [action].compactMap {
                $0?.description
            }
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

    public extension CACollectionView {
        convenience init(frame: CGRect, collectionViewLayout: CACollectionViewLayout) {
            self.init(frame: frame)
            self.collectionViewLayout = collectionViewLayout
        }

        func register(
            _ cellClass: AnyClass?,
            forCellWithReuseIdentifier identifier: String
        ) {
            register(cellClass, forItemWithIdentifier: .init(identifier))
        }
    }
#endif
