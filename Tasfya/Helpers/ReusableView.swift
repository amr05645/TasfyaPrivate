//
//  ReusableView.swift
//  Tasfya
//
//  Created by Elsaadany on 06/04/2021.
//

import Foundation

protocol ReusableView: AnyObject {}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
