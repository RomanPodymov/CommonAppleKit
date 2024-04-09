//
//  CAListViewCell.swift
//  CommonAppleKit
//
//  Created by Roman Podymov on 18/10/2023.
//  Copyright © 2023 CommonAppleKit. All rights reserved.
//

import Foundation

public protocol CAListViewCellDelegate: AnyObject {
    func onCellTap(data: Any?)
    func onAction(data: Any?)
    func pageEndReached()
}

open class CAListViewCell<RootView: CAView>: CACollectionViewCell {
    public unowned var rootView: RootView!
    public weak var delegate: CAListViewCellDelegate?

    open func createRootView(frame: CARect) -> RootView {
        RootView(frame: frame)
    }

    #if canImport(AppKit)
        open override func loadView() {
            let rootView = createRootView(frame: .zero)
            view = rootView
            self.rootView = rootView
        }
    #elseif canImport(UIKit)
        open var representedObject: Any?

        override init(frame: CGRect) {
            super.init(frame: frame)

            let rootView = createRootView(frame: frame)
            rootView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(rootView)
            self.rootView = rootView
            rootView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            rootView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            rootView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            rootView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        }

        required public init?(coder _: NSCoder) {
            nil
        }
    #endif
}
