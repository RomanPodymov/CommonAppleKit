//
//  CAScrollableListView.swift
//  CommonAppleKit
//
//  Created by Roman Podymov on 18/10/2023.
//  Copyright © 2023 CommonAppleKit. All rights reserved.
//

import Foundation

#if canImport(AppKit)
open class CAScrollableListView<Cell: CAListViewCell>: CAScrollView {
    public var content: [Any] = [] {
        didSet {
            (documentView as? CAListView<Cell>)?.content = content
        }
    }

    public init(frame: CGRect, itemSize: CGSize, cellId: String) {
        super.init(frame: frame)
        let listView = CAListView<Cell>(frame: frame, itemSize: itemSize, cellId: cellId)
        documentView = listView
    }
    
    required public init?(coder _: NSCoder) {
        nil
    }
}
#elseif canImport(UIKit)
public typealias CAScrollableListView<Cell: CAListViewCell> = CAListView<Cell>
#endif
