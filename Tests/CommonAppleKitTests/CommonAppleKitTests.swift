//
//  CommonAppleKitTests.swift
//  CommonAppleKitTests
//
//  Created by Roman Podymov on 15/10/2023.
//  Copyright © 2023 CommonAppleKit. All rights reserved.
//

import XCTest
import CommonAppleKit

private final class ControllerA: CAViewController { }

private final class ControllerB: CAViewController { }

private final class CellA: CAListViewCell { }

private final class ViewA: CAView {
    override init(frame: CARect) {
        super.init(frame: frame)

        addSubview(CALabel())
        addSubview(CATextField())
        #if canImport(AppKit)
        layer?.backgroundColor = CAColor.red.cgColor
        #elseif canImport(UIKit)
        backgroundColor = CAColor.red
        #endif
    }
    
    required init?(coder: NSCoder) {
        nil
    }
}

final class CommonAppleKitTests: XCTestCase {
    func testButton() {
        let button = CAButton()
        let selector = #selector(Self.onButtonTap)
        button.addTargetForPrimaryActionTriggered(self, action: selector)
        let actions = button.actions(for: self)
        XCTAssertEqual([selector].map { $0.description }, actions)
    }

    @objc private func onButtonTap() {

    }

    func testTabBarController() {
        let tabBarController = CATabBarController()
        let viewControllers = [
            ControllerA(),
            ControllerB()
        ]
        tabBarController.viewControllers = viewControllers
        XCTAssertEqual(viewControllers, tabBarController.viewControllers)
    }

    func testView() {
        let view = ViewA(frame: .zero)

        XCTAssertTrue(view.subviews.contains { $0 is CALabel })
        XCTAssertTrue(view.subviews.contains { $0 is CATextField })
    }

    func testCollectionView() {
        let layout: CACollectionViewLayout = CACollectionViewFlowLayout()
        let collectionView = CACollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CACollectionViewCell.self, forCellWithReuseIdentifier: "id")
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func testListView() {
        let listView = CAListView<CellA>(frame: .zero, itemSize: .init(width: 200, height: 100), cellId: "id")
        listView.content = []
    }

    func testScrollableListView() {
        let listView = CAScrollableListView<CellA>(frame: .zero, itemSize: .init(width: 200, height: 100), cellId: "id")
        listView.content = []
    }
}

extension CommonAppleKitTests: CACollectionViewDataSource {
    func collectionView(_ collectionView: CACollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    #if canImport(UIKit)
    func collectionView(_ collectionView: CACollectionView, cellForItemAt indexPath: IndexPath) -> CACollectionViewCell {
        fatalError()
    }
    #else
    func collectionView(_ collectionView: CACollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> CACollectionViewCell {
        fatalError()
    }

    func collectionView(_: CACollectionView, willDisplay item: CACollectionViewCell, forRepresentedObjectAt _: IndexPath) {

    }
    #endif
}

extension CommonAppleKitTests: CACollectionViewDelegate { }

extension CommonAppleKitTests: CACollectionViewDelegateFlowLayout { }
