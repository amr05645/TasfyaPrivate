//
//  UIViewController+Extension.swift
//  Tasfya
//
//  Created by Elsaadany on 19/04/2021.
//

import UIKit

extension UIViewController {
    func showAlert(message: String, title: String = "", completionHandler: @escaping (() -> ())) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: Constants.titles.ok, style: .default, handler: {_ in
            completionHandler()
        })
        let cancelAction = UIAlertAction(title: Constants.titles.cancel, style: .destructive, handler: nil)
        alertController.addAction(OKAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
