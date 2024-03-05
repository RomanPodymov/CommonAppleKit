//
//  CAScreenItem.swift
//  CommonAppleKit
//
//  Created by Roman Podymov on 05/03/2024.
//  Copyright © 2024 CommonAppleKit. All rights reserved.
//

open class CAScreenItem: CAView {
    #if canImport(UIKit)
    open override func traitCollectionDidChange(_ previousTraitCollection: CATraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        didChangeTraitCollection()
    }
    #endif

    open func didChangeTraitCollection() {

    }
}
