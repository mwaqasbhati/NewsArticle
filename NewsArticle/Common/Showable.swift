//
//  Showable.swift
//  Cezan
//
//  Created by Muhammad Waqas on 5/19/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import Foundation
import PKHUD

protocol Showable {
    func showError(_ message: String)
    func showProgress()
    func hideProgress()
}

extension Showable {
    func showError(_ message: String) {
        if Thread.isMainThread {
            HUD.flash(.label(message), delay: 2.0)
        } else {
            DispatchQueue.main.async {
                HUD.flash(.label(message), delay: 2.0)
            }
        }
    }
    func showProgress() {
        if Thread.isMainThread {
            HUD.show(.progress)
        } else {
            DispatchQueue.main.async {
                HUD.show(.progress)
            }
        }
    }
    func hideProgress() {
        if Thread.isMainThread {
            HUD.hide()
        } else {
            DispatchQueue.main.async {
                HUD.hide()
            }
        }
    }
}
