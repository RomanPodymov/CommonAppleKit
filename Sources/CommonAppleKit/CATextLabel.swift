//
//  CATextLabel.swift
//  CommonAppleKit
//
//  Created by Roman Podymov on 25/12/2023.
//  Copyright © 2023 CommonAppleKit. All rights reserved.
//

import Foundation

open class CATextLabel: CALabel {
    public override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

        #if canImport(UIKit)
        numberOfLines = 0
        #elseif canImport(AppKit)
        isEditable = false
        #endif
    }
    
    required public init?(coder: NSCoder) {
        nil
    }
}
