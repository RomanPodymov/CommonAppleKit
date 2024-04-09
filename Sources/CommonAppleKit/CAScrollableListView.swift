//
//  CAScrollableListView.swift
//  CommonAppleKit
//
//  Created by Roman Podymov on 18/10/2023.
//  Copyright © 2023 CommonAppleKit. All rights reserved.
//

import Foundation
import CoreGraphics

#if canImport(AppKit)
open class CAScrollableListView<
    Cell: CAListViewCell<CellRootView>,
    Footer: CACollectionReusableView,
    CellRootView,
    CellDataType
>: CAScrollView {
    public var content: [CellDataType] = [] {
        didSet {
            (documentView as? CAListView<Cell, Footer, CellRootView, CellDataType>)?.content = content
        }
    }

    public init(
        frame: CGRect,
        itemSize: CGSize,
        minimumInteritemSpacing: CGFloat = 0,
        minimumLineSpacing: CGFloat = 0,
        footerReferenceSize: CGSize = .zero,
        cellId: String = .init(describing: Cell.self),
        cellDelegate: CAListViewCellDelegate? = nil,
        footerId: String = .init(describing: Footer.self)
    ) {
        super.init(frame: frame)
        let listView = CAListView<Cell, Footer, CellRootView, CellDataType>(
            frame: frame,
            itemSize: itemSize,
            minimumInteritemSpacing: minimumInteritemSpacing,
            minimumLineSpacing: minimumLineSpacing,
            footerReferenceSize: footerReferenceSize,
            cellId: cellId,
            cellDelegate: cellDelegate,
            footerId: footerId
        )
        documentView = listView
    }
    
    required public init?(coder _: NSCoder) {
        nil
    }
}
#elseif canImport(UIKit)
open class CAScrollableListView<
    Cell: CAListViewCell<CellRootView>,
    Footer: CACollectionReusableView,
    CellRootView,
    CellDataType
>: CAListView<Cell, Footer, CellRootView, CellDataType> {
    open var documentView: CAView? {
        self
    }
}
#endif
