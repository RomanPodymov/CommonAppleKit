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
    Header: CACollectionReusableView,
    Footer: CACollectionReusableView,
    CellRootView,
    CellDataType
>: CAScrollView {
    public var content: [CellDataType] = [] {
        didSet {
            (documentView as? CAListView<Cell, Header, Footer, CellRootView, CellDataType>)?.content = content
        }
    }

    public init(
        frame: CGRect,
        itemSize: CGSize,
        minimumInteritemSpacing: CGFloat = 0,
        minimumLineSpacing: CGFloat = 0,
        headerReferenceSize: CGSize = .zero,
        footerReferenceSize: CGSize = .zero,
        cellId: String = .init(describing: Cell.self),
        headerId: String = .init(describing: Header.self),
        footerId: String = .init(describing: Footer.self),
        cellDelegate: CAListViewCellDelegate? = nil
    ) {
        super.init(frame: frame)
        let listView = CAListView<Cell, Header, Footer, CellRootView, CellDataType>(
            frame: frame,
            itemSize: itemSize,
            minimumInteritemSpacing: minimumInteritemSpacing,
            minimumLineSpacing: minimumLineSpacing,
            headerReferenceSize: headerReferenceSize,
            footerReferenceSize: footerReferenceSize,
            cellId: cellId,
            headerId: headerId,
            footerId: footerId,
            cellDelegate: cellDelegate
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
    Header: CACollectionReusableView,
    Footer: CACollectionReusableView,
    CellRootView,
    CellDataType
>: CAListView<Cell, Header, Footer, CellRootView, CellDataType> {
    open var documentView: CAView? {
        self
    }
}
#endif
