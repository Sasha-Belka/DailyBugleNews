//
//  addChild.swift
//  DailyBugle_V_1.0.0
//
//  Created by Oleksandr Kostogryz on 30.07.2021.
//

import UIKit

// MARK: - Child management
extension UIViewController {

    func addChild(_ child: UIViewController, toContainer container: UIView) {

        addChild(child)

        child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        child.view.frame = container.bounds
        container.addSubview(child.view)

        child.didMove(toParent: self)
    }
}
