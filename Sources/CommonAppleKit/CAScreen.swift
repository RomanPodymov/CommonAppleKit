//
//  CAScreen.swift
//  CommonAppleKit
//
//  Created by Roman Podymov on 20/12/2023.
//  Copyright © 2023 CommonAppleKit. All rights reserved.
//

open class CAScreen: CAViewController {
    override open func viewWillAppear() {
        super.viewWillAppear()
        willAppear()
    }

    open override func viewDidAppear() {
        super.viewDidAppear()
        didAppear()
    }

    open func willAppear() {

    }

    open func didAppear() {

    }
}
