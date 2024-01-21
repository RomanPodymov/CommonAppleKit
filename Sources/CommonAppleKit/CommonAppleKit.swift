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
    public typealias CASecureTextField = UITextField
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
    public typealias CAWindow = UIWindow
    public typealias CARect = CGRect
    public typealias CALayoutGuide = UILayoutGuide
    #if !os(tvOS)
    public typealias CADatePicker = UIDatePicker
    #endif
    public typealias CATraitCollection = UITraitCollection
    public typealias CAUserInterfaceStyle = UIUserInterfaceStyle
    public typealias CAFont = UIFont
    public typealias CAEdgeInsets = UIEdgeInsets
    public typealias CAStackView = UIStackView

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

    public extension CALabel {
        var stringValue: String {
            get {
                text ?? ""
            }
            
            set {
                text = newValue
            }
        }

        var alignment: NSTextAlignment {
            get {
                textAlignment
            }

            set {
                textAlignment = newValue
            }
        }
    }

    public extension CAButton {
        private static var states: [UIControl.State] {
            [.normal, .selected, .highlighted, .disabled, .focused]
        }

        func setTitle(_ title: String) {
            Self.states.forEach { state in
                setTitle(title, for: state)
            }
        }

        func setImage(_ image: CAImage) {
            Self.states.forEach { state in
                setImage(image, for: state)
            }
        }

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

    public extension CAViewController {
        func present(_ viewControllerToPresent: CAViewController) {
            present(viewControllerToPresent, animated: true)
        }

        var presentedViewControllers: [CAViewController]? {
            presentedViewController.map { [$0] }
        }

        func dismiss(_ viewController: CAViewController) {
            viewController.dismiss(animated: true)
        }
    }
#elseif canImport(AppKit)
    public enum CAUserInterfaceStyle {
        case dark
        case light
        case unspecified
    }

    public class CATraitCollection: NSObject {
        public let userInterfaceStyle: CAUserInterfaceStyle = .light
    }

    import AppKit

    public typealias CAView = NSView
    public typealias CAViewController = NSViewController
    public typealias CAApplicationDelegate = NSApplicationDelegate
    public typealias CAAppDelegateBaseClass = NSObject
    public typealias CATabBarController = NSTabViewController
    public typealias CAButton = NSButton
    public typealias CATextField = NSTextField
    public typealias CASecureTextField = NSSecureTextField
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
    public typealias CAWindow = NSWindow
    public typealias CARect = NSRect
    public typealias CALayoutGuide = NSLayoutGuide
    public typealias CADatePicker = NSDatePicker
    public typealias CAFont = NSFont
    public typealias CAEdgeInsets = NSEdgeInsets
    public typealias CAStackView = NSStackView

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

    public extension CAImage {
        @available(macOS 11.0, *)
        convenience init?(systemName: String) {
            self.init(systemSymbolName: systemName, accessibilityDescription: nil)
        }
    }

    public extension CAButton {
        func setTitle(_ title: String) {
            self.title = title
        }

        func setImage(_ image: CAImage) {
            self.image = image
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
        var viewControllers: [CAViewController]? {
            get {
                tabViewItems.compactMap(\.viewController)
            }

            set {
                tabViewItems = newValue?.map {
                    .init(viewController: $0)
                } ?? []
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

    public extension CAWindow {
        var rootViewController: CAViewController? {
            get {
                contentViewController
            }

            set {
                contentViewController = newValue
            }
        }
    }

    public extension CAViewController {
        func present(_ viewControllerToPresent: CAViewController) {
            presentAsModalWindow(viewControllerToPresent)
        }

        var traitCollection: CATraitCollection {
            .init()
        }
    }
#endif

public extension CAButton {
    func setSystemImage(_ systemName: String, tintColor: CAColor? = nil) {
        let image: CAImage?
        if #available(macOS 11.0, iOS 13.0, tvOS 13.0, *) {
            image = CAImage(systemName: systemName)
        } else {
            image = nil
        }
        if let image {
            setImage(tintColor.map { image.withTint(color: $0) } ?? image)
        } else {
            setTitle(systemName)
        }
    }
}

private extension CAImage {
    func withTint(color: CAColor) -> CAImage {
        #if canImport(AppKit)
        .init(size: size, flipped: false) { rect -> Bool in
            color.set()
            rect.fill()
            self.draw(in: rect, from: .init(origin: .zero, size: self.size), operation: .destinationIn, fraction: 1.0)
            return true
        }
        #elseif canImport(UIKit)
        defer { UIGraphicsEndImageContext() }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        withRenderingMode(.alwaysTemplate).draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
        #endif
    }
}

#if canImport(AppKit)
extension CAEdgeInsets: Equatable {
    public static func == (lhs: CAEdgeInsets, rhs: CAEdgeInsets) -> Bool {
        lhs.bottom == rhs.bottom && lhs.left == rhs.left && lhs.top == rhs.top && lhs.right == rhs.right
    }
}
#endif
