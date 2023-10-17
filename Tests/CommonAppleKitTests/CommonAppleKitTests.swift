//
//  CommonAppleKitTests.swift
//  CommonAppleKitTests
//
//  Created by Roman Podymov on 15/10/2023.
//  Copyright © 2023 CommonAppleKit. All rights reserved.
//

import XCTest
@testable import CommonAppleKit

private final class ControllerA: CAViewController { }

private final class ControllerB: CAViewController { }

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

    func testCollectionView() {
        let layout = CACollectionViewFlowLayout()
        let collectionView = CACollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CACollectionViewCell.self, forCellWithReuseIdentifier: "id")
        collectionView.dataSource = self
        collectionView.delegate = self
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
    #endif
}

extension CommonAppleKitTests: CACollectionViewDelegate { }

extension CommonAppleKitTests: CACollectionViewDelegateFlowLayout { }
