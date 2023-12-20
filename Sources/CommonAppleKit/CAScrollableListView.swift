//
//  CAScrollableListView.swift
//  CommonAppleKit
//
//  Created by Roman Podymov on 18/10/2023.
//  Copyright © 2023 CommonAppleKit. All rights reserved.
//

import Foundation

#if canImport(AppKit)
open class CAScrollableListView<Cell: CAListViewCell<CellRootView>, CellRootView, CellDataType: Any>: CAScrollView {
    public var content: [CellDataType] = [] {
        didSet {
            (documentView as? CAListView<Cell, CellRootView, CellDataType>)?.content = content
        }
    }

    public init(frame: CGRect, itemSize: CGSize, cellId: String = .init(describing: Cell.self), cellDelegate: CAListViewCellDelegate? = nil) {
        super.init(frame: frame)
        let listView = CAListView<Cell, CellRootView, CellDataType>(frame: frame, itemSize: itemSize, cellId: cellId, cellDelegate: cellDelegate)
        documentView = listView
    }
    
    required public init?(coder _: NSCoder) {
        nil
    }
}
#elseif canImport(UIKit)
public typealias CAScrollableListView<Cell: CAListViewCell<CellRootView>, CellRootView, CellDataType: Any> = CAListView<Cell, CellRootView, CellDataType>
#endif
