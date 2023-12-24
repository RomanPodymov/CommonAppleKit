//
//  CAScreen.swift
//  CommonAppleKit
//
//  Created by Roman Podymov on 20/12/2023.
//  Copyright © 2023 CommonAppleKit. All rights reserved.
//

open class CAScreen: CAViewController {
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
