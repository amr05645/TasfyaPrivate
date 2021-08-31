//
//  UIImageView+Extension.swift
//  Tasfya
//
//  Created by Elsaadany on 07/04/2021.
//

import UIKit
import Kingfisher

@IBDesignable
extension UIImageView {
    
    @IBInspectable var imageTint: UIColor {
        get {return self.tintColor}
        set {self.image = self.image?.withRenderingMode(.alwaysTemplate)
            self.tintColor =
                newValue}
    }
}

extension UIImageView {
    func showImage(url: String?, cornerRadius: CGFloat) {
        guard let url = url else {return}
        guard let imageUrl = URL(string: url) else {return}
        self.kf.setImage(with: imageUrl)
        self.kf.setImage(with: imageUrl)
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
            |> RoundCornerImageProcessor(cornerRadius: cornerRadius)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: imageUrl,
            placeholder: nil,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
