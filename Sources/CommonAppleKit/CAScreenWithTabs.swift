//
//  CAScreenWithTabs.swift
//  CommonAppleKit
//
//  Created by Roman Podymov on 06/03/2024.
//  Copyright © 2024 CommonAppleKit. All rights reserved.
//

open class CAScreenWithTabs: CATabBarController {
    #if canImport(AppKit)
    override open func viewWillAppear() {
        super.viewWillAppear()
        willAppear()
    }

    open override func viewDidAppear() {
        super.viewDidAppear()
        didAppear()
    }
    #elseif canImport(UIKit)
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        willAppear()
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        didAppear()
    }
    #endif

    #if canImport(UIKit)
    open override func traitCollectionDidChange(_ previousTraitCollection: CATraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        didChangeTraitCollection()
    }
    #endif

    open func willAppear() {

    }

    open func didAppear() {

    }

    open func didChangeTraitCollection() {

    }
}
