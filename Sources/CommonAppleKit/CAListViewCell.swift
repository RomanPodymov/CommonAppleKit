//
//  CAListViewCell.swift
//  CommonAppleKit
//
//  Created by Roman Podymov on 18/10/2023.
//  Copyright © 2023 CommonAppleKit. All rights reserved.
//

import Foundation

open class CAListViewCell<RootView: CAView>: CACollectionViewCell {
    public unowned var rootView: RootView!

    open func createRootView() -> RootView {
        RootView(frame: .zero)
    }

    #if canImport(AppKit)
        open override func loadView() {
            view = createRootView()
            rootView = view
        }
    #elseif canImport(UIKit)
        open var representedObject: Any?

        override init(frame: CGRect) {
            super.init(frame: frame)

            let rootView = createRootView()
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
