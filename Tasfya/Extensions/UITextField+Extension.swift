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
    
    @IBInspectable
    override var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    override var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    override var borderColor: UIColor {
        get {
            return UIColor.white
        }
        
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable
    override var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            
            layer.shadowRadius = newValue
        }
    }
    @IBInspectable
    override var shadowOffset : CGSize{
        
        get{
            return layer.shadowOffset
        }set{
            
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    override var shadowColor : UIColor{
        get{
            return UIColor.init(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    @IBInspectable
    override var shadowOpacity : Float {
        
        get{
            return layer.shadowOpacity
        }
        set {
            
            layer.shadowOpacity = newValue
            
        }
    }
    
    func dropShadow(shadowOffsetWidth: CGFloat = 0, shadowOffsetHeight: CGFloat = 0, shadowRadius: CGFloat = 1.5) {
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = 0.3
        layer.masksToBounds = false
    }
}
