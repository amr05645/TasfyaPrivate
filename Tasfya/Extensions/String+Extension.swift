//
//  String+Extension.swift
//  Tasfya
//
//  Created by Amr on 21/08/2021.
//

import Foundation

extension String {

  var localized: String {
    return NSLocalizedString(self, comment: "\(self)_comment")
  }
}
