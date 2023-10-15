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
        button.addTargetForPrimaryActionTriggered(self, action: #selector(Self.onButtonTap))
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
}
