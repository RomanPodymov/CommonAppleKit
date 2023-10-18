//
//  ListViewCell.swift
//  CommonAppleKit
//
//  Created by Roman Podymov on 18/10/2023.
//  Copyright © 2023 CommonAppleKit. All rights reserved.
//

import Foundation

open class ListViewCell: CACollectionViewCell {
    #if canImport(UIKit)
    open var representedObject: Any?
    #endif
}
