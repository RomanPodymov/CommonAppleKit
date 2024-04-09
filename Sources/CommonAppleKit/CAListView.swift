//
//  CAListView.swift
//  CommonAppleKit
//
//  Created by Roman Podymov on 18/10/2023.
//  Copyright © 2023 CommonAppleKit. All rights reserved.
//

import Foundation
import CoreGraphics

open class CAListView<
    Cell: CAListViewCell<CellRootView>,
    Footer: CACollectionReusableView,
    CellRootView,
    CellDataType
>: CACollectionView, CACollectionViewDataSource, CACollectionViewDelegate {
    private let cellId: String
    private let footerId: String
    private weak var cellDelegate: CAListViewCellDelegate?

    #if canImport(UIKit)
    open var previousContent: [CellDataType] = []

    open var content: [CellDataType] = [] {
        willSet {
            previousContent = content
        }

        didSet {
            reload()
        }
    }

    open func reload() {
        reloadData()
    }
    #endif

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
        self.cellId = cellId
        self.footerId = footerId
        self.cellDelegate = cellDelegate
        let layout = CACollectionViewFlowLayout()
        layout.itemSize = itemSize
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.minimumLineSpacing = minimumLineSpacing
        layout.footerReferenceSize = footerReferenceSize
        #if canImport(AppKit)
        super.init(frame: frame)
        collectionViewLayout = layout
        #elseif canImport(UIKit)
        super.init(frame: frame, collectionViewLayout: layout)
        #endif

        register(Cell.self, forCellWithReuseIdentifier: cellId)
        register(
            Footer.self,
            forSupplementaryViewOfKind: CACollectionView.elementKindSectionFooter,
            withReuseIdentifier: footerId
        )

        delegate = self
        #if canImport(UIKit)
            dataSource = self
        #endif
    }

    required public init?(coder _: NSCoder) {
        nil
    }

    public func collectionView(_ collectionView: CACollectionView, numberOfItemsInSection section: Int) -> Int {
        content.count
    }

    public func collectionView(_ collectionView: CACollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> CACollectionReusableView {
        if kind == CACollectionView.elementKindSectionFooter {
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: CACollectionView.elementKindSectionFooter,
                withReuseIdentifier: footerId,
                for: indexPath
            )
            return view
        }
        return .init()
    }

    public func collectionView(_ collectionView: CACollectionView, willDisplaySupplementaryView view: CACollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        cellDelegate?.pageEndReached()
    }

    #if canImport(AppKit)
    public func collectionView(_ collectionView: CACollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> CACollectionViewCell {
        collectionView.makeItem(withIdentifier: .init(cellId), for: indexPath)
    }

    public func collectionView(_ collectionView: CACollectionView, willDisplay cell: CACollectionViewCell, forRepresentedObjectAt indexPath: IndexPath) {
        (cell as? Cell)?.delegate = cellDelegate
    }

    public func collectionView(_ collectionView: CACollectionView, didEndDisplaying item: CACollectionViewCell, forRepresentedObjectAt indexPath: IndexPath) {

    }
    #elseif canImport(UIKit)
    public func collectionView(_ collectionView: CACollectionView, didSelectItemAt indexPath: IndexPath) {
        cellDelegate?.onCellTap(data: content[indexPath.item])
    }

    public func collectionView(_ collectionView: CACollectionView, cellForItemAt indexPath: IndexPath) -> CACollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        (cell as? Cell)?.delegate = cellDelegate
        (cell as? Cell)?.representedObject = content[indexPath.item]
        return cell
    }
    #endif
}
