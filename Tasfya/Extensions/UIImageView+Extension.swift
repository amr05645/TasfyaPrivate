//
//  UIImageView+Extension.swift
//  Tasfya
//
//  Created by Elsaadany on 07/04/2021.
//

import UIKit

@IBDesignable
extension UIImageView {
    
    @IBInspectable var imageTint: UIColor {
        get {return self.tintColor}
        set {self.image = self.image?.withRenderingMode(.alwaysTemplate)
            self.tintColor =
                newValue}
    }
}
