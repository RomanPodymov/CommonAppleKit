//
//  CommonAppleKitTests.swift
//  CommonAppleKitTests
//
//  Created by Roman Podymov on 15/10/2023.
//  Copyright © 2023 CommonAppleKit. All rights reserved.
//

import XCTest
import CommonAppleKit

private final class ControllerA: CAScreen {
    override func willAppear() { }

    override func didChangeTraitCollection() { }
}

private final class ControllerB: CAScreen {
    override func didAppear() { }
}

private final class CellA: CAListViewCell<CellARootView> {
    override func createRootView(frame: CARect) -> CellARootView {
        let result = CellARootView(frame: frame)
        result.cell = self
        return result
    }
}

private final class CellARootView: CAView {
    fileprivate weak var cell: CellA?
}

private final class HeaderA: CACollectionReusableView { }

private final class FooterA: CACollectionReusableView { }

private final class ViewA: CAView {
    override init(frame: CARect) {
        super.init(frame: frame)

        let label = CATextLabel()
        label.font = CAFont.systemFont(ofSize: 20)
        label.stringValue = "Hello"
        label.alignment = .center
        addSubview(label)
        addSubview(CATextField())
        let secureTextField = CASecureTextField()
        secureTextField.isSecureTextEntry = true
        addSubview(secureTextField)
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
    func testTextField() {
        let textField = CATextField()
        textField.stringValue = "Hello"
        textField.placeholder = "world"
        XCTAssertEqual(textField.stringValue, "Hello")
        XCTAssertEqual(textField.placeholder, "world")
    }

    func testButton() {
        let button = CAButton()
        #if canImport(UIKit)
        button.contentEdgeInsets = CAEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        #endif
        let selector = #selector(Self.onButtonTap)
        button.addTargetForPrimaryActionTriggered(self, action: selector)
        let actions = button.actions(for: self)
        XCTAssertEqual([selector].map { $0.description }, actions)
    }

    @objc private func onButtonTap() {

    }

    #if canImport(AppKit)
    func testStackView() {
        let stackView = CAStackView()
        let edgeInsets = CAEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        stackView.edgeInsets = edgeInsets
        XCTAssertEqual(stackView.edgeInsets, edgeInsets)
    }
    #endif

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

        XCTAssertTrue(view.subviews.contains {
            if let label = $0 as? CATextLabel,
                label.stringValue == "Hello",
                label.alignment == .center {
                return true
            }
            return false
        })
        XCTAssertTrue(view.subviews.contains { $0 is CATextField })
        XCTAssertTrue(view.subviews.contains {
            guard let secureTextField = $0 as? CASecureTextField else {
                return false
            }
            return secureTextField.isSecureTextEntry
        })
    }

    func testCollectionView() {
        let layout: CACollectionViewLayout = CACollectionViewFlowLayout()
        let collectionView = CACollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CACollectionViewCell.self, forCellWithReuseIdentifier: "id")
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func testListView() {
        let listView = CAListView<CellA, HeaderA, FooterA, CellARootView, String>(
            frame: .init(
                x: 0,
                y: 0,
                width: 300,
                height: 500
            ),
            itemSize: .init(
                width: 200,
                height: 100
            ),
            cellId: "id",
            cellDelegate: self
        )
        listView.content = ["one", "two"]
    }

    func testScrollableListView() {
        let listView = CAScrollableListView<CellA, HeaderA, FooterA, CellARootView, Int>(
            frame: .zero,
            itemSize: .init(
                width: 200,
                height: 100
            ),
            headerReferenceSize: .init(
                width: 300,
                height: 400
            ),
            footerReferenceSize: .init(
                width: 300,
                height: 400
            )
        )
        listView.footerReferenceSize = .init(width: 200, height: 100)
        listView.content = [1, 2]
    }
}

extension CommonAppleKitTests: CAListViewCellDelegate {
    #if canImport(UIKit)
    func onCellTap(data: Any?) {

    }
    #endif

    func onAction(data: Any?) {

    }

    func onHeaderWillBeDisplayed() {

    }

    func onFooterWillBeDisplayed() {

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
