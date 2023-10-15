//
//  CommonAppleKitTests.swift
//  CommonAppleKitTests
//
//  Created by Roman Podymov on 15/10/2023.
//  Copyright © 2023 CommonAppleKit. All rights reserved.
//

import XCTest
@testable import CommonAppleKit

final class CommonAppleKitTests: XCTestCase {
    func testButton() {
        let button = CAButton()
        button.addTargetForPrimaryActionTriggered(self, action: #selector(Self.onButtonTap))
    }

    @objc private func onButtonTap() {

    }

    func testTabBarController() {
        let tabBarController = CATabBarController()
        tabBarController.viewControllers = [
            .init(),
            .init()
        ]
    }
}
