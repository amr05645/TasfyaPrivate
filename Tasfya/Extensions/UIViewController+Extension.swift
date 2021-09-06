//
//  UIViewController+Extension.swift
//  Tasfya
//
//  Created by Elsaadany on 19/04/2021.
//

import UIKit
import PKHUD

extension UIViewController {
    
    func dataExist(in textFields: [UITextField]) -> Bool {
        var status = true
        for textField in textFields {
            status = !(textField.text?.isEmpty ?? true)
            textField.borderWidth = status ? 0 : 0.5
            textField.borderColor = .red
        }
        return status
    }
    
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
    
    func showAlert(with message: String) {
        HUD.flash(.label(message), delay: 1)
    }
    
    func showProgress() {
        HUD.show(.progress)
    }
    
    func hideProgress() {
        HUD.hide()
    }
    
}
