//
//  Extensions.swift
//  Cezan
//
//  Created by Muhammad Waqas on 5/11/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import Foundation
import UIKit


extension UILabel {
    
    @IBInspectable
    var letterSpace: CGFloat {
        set {
            let attributedString: NSMutableAttributedString!
            if let currentAttrString = attributedText {
                attributedString = NSMutableAttributedString(attributedString: currentAttrString)
            } else {
                attributedString = NSMutableAttributedString(string: text ?? "")
                text = nil
            }
            attributedString.addAttribute(NSAttributedString.Key.kern,
                                          value: newValue,
                                          range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
        
        get {
            if let currentLetterSpace = attributedText?.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: .none) as? CGFloat {
                return currentLetterSpace
            } else {
                return 0
            }
        }
    }
}

extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}

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

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

@IBDesignable
class CustomButton: UIButton {
}
@IBDesignable
class CustomView: UIView {
}


extension UIView {
    @IBInspectable var borderColor: UIColor? {
        set {
            self.layer.borderColor = borderColor?.cgColor
        }
        get {
            return nil
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            self.layer.borderWidth = borderWidth
        }
        get {
            return self.layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat  {
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
        get {
            return self.layer.cornerRadius
        }
    }
    
    @IBInspectable var dropShadow: Bool {
        set {
            if newValue == true {
                addShadow()
            }
        }
        get {
            return false
        }
    }
    func addShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(hexString: "#a7a7a7").cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}

extension UIImage {
    var roundedImage: UIImage {
        let rect = CGRect(origin:CGPoint(x: 0, y: 0), size: self.size)
        UIGraphicsBeginImageContextWithOptions(self.size, false, 1)
        UIBezierPath(
            roundedRect: rect,
            cornerRadius: self.size.height
            ).addClip()
        self.draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
    func squareMyImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: self.size.width, height: self.size.width))
        
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.width))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
