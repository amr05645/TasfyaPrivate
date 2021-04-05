//
//  UITextField+Extension.swift
//  Tasfya
//
//  Created by Elsaadany on 05/04/2021.
//

import UIKit

@IBDesignable
extension UITextField {
    @IBInspectable var placeHolderColor: UIColor {
        get {
            return UIColor()
        }
        
        set {
            let redPlaceholderText = NSAttributedString(string: self.placeholder ?? "",
                                                                attributes: [NSAttributedString.Key.foregroundColor: newValue])
                    
                    self.attributedPlaceholder = redPlaceholderText
        }
    }
}
