//
//  SettingsVC.swift
//  Tasfya
//
//  Created by Elsaadany on 05/04/2021.
//

import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet weak var languageTF: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func privacyTapped(_ sender: Any) {
    }
    
    @IBAction func languageTapped(_ sender: Any) {
        languageTF.becomeFirstResponder()
    }
    
    @IBAction func aboutTapped(_ sender: Any) {
    }
}
