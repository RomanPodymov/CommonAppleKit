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

    #if canImport(UIKit)
    public var content: [Any] = [] {
        didSet {
            reloadData()
        }
    }
    #endif

    public init(frame: CGRect, itemSize: CGSize, cellId: String = String(describing: Cell.self)) {
        self.cellId = cellId
        let layout = CACollectionViewFlowLayout()
        layout.itemSize = itemSize
        #if canImport(AppKit)
        super.init(frame: frame)
        collectionViewLayout = layout
        #elseif canImport(UIKit)
        super.init(frame: frame, collectionViewLayout: layout)
        #endif

        register(Cell.self, forCellWithReuseIdentifier: cellId)

        #if canImport(UIKit)
            dataSource = self
            delegate = self
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
    #elseif canImport(UIKit)
    public func collectionView(_ collectionView: CACollectionView, didSelectItemAt indexPath: IndexPath) {

    }

    public func collectionView(_ collectionView: CACollectionView, cellForItemAt indexPath: IndexPath) -> CACollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        (cell as? Cell)?.representedObject = content[indexPath.item]
        return cell
    }
    #endif
}
