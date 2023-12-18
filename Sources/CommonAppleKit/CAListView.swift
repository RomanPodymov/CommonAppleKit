//
//  CAListView.swift
//  CommonAppleKit
//
//  Created by Roman Podymov on 18/10/2023.
//  Copyright © 2023 CommonAppleKit. All rights reserved.
//

import Foundation

open class CAListView<Cell: CAListViewCell<CellRootView>, CellRootView>: CACollectionView, CACollectionViewDataSource, CACollectionViewDelegate {
    private let cellId: String
    private weak var cellDelegate: CAListViewCellDelegate?

    #if canImport(UIKit)
    public var content: [Any] = [] {
        didSet {
            reloadData()
        }
    }
    #endif

    public init(frame: CGRect, itemSize: CGSize, cellId: String = .init(describing: Cell.self), cellDelegate: CAListViewCellDelegate? = nil) {
        self.cellId = cellId
        self.cellDelegate = cellDelegate
        let layout = CACollectionViewFlowLayout()
        layout.itemSize = itemSize
        #if canImport(AppKit)
        super.init(frame: frame)
        collectionViewLayout = layout
        #elseif canImport(UIKit)
        super.init(frame: frame, collectionViewLayout: layout)
        #endif

        register(Cell.self, forCellWithReuseIdentifier: cellId)

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

    #if canImport(AppKit)
    public func collectionView(_ collectionView: CACollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> CACollectionViewCell {
        fatalError()
    }

    public func collectionView(_ collectionView: CACollectionView, willDisplay cell: CACollectionViewCell, forRepresentedObjectAt indexPath: IndexPath) {
        (cell as? Cell)?.delegate = cellDelegate
    }

    public func collectionView(_ collectionView: CACollectionView, didEndDisplaying item: CACollectionViewCell, forRepresentedObjectAt indexPath: IndexPath) {

    }
    #elseif canImport(UIKit)
    public func collectionView(_ collectionView: CACollectionView, didSelectItemAt indexPath: IndexPath) {

    }

    public func collectionView(_ collectionView: CACollectionView, cellForItemAt indexPath: IndexPath) -> CACollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        (cell as? Cell)?.delegate = cellDelegate
        (cell as? Cell)?.representedObject = content[indexPath.item]
        return cell
    }
    #endif
}
