//
//  Extensions.swift
//  Cezan
//
//  Created by Muhammad Waqas on 5/11/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func presentAlert(withTitle title: String, message : String, alertActions: [UIAlertAction]? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if alertActions != nil {
            for action in alertActions! {
                alertController.addAction(action)
            }
        } else {
            //default
            let OKAction = UIAlertAction(title: "OK", style: .default) { action in
                print("You've pressed OK Button")
            }
            alertController.addAction(OKAction)
        }
        self.present(alertController, animated: true, completion: nil)
    }
}







