//
//  ListView.swift
//  CommonAppleKit
//
//  Created by Roman Podymov on 18/10/2023.
//  Copyright © 2023 CommonAppleKit. All rights reserved.
//

import Foundation

public final class ListView<Cell: CACollectionViewCell>: CACollectionView, CACollectionViewDataSource {
    #if canImport(UIKit)
    var content: [Any] = [] {
        didSet {
            reloadData()
        }
    }
    #endif

    public init(frame: CGRect, itemSize: CGSize, cellId: String) {
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
        #endif
    }

    required init?(coder _: NSCoder) {
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
    public func collectionView(_ collectionView: CACollectionView, cellForItemAt indexPath: IndexPath) -> CACollectionViewCell {
        fatalError()
    }
    #endif
}
