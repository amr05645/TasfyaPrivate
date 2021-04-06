//
//  SettingsVC.swift
//  Tasfya
//
//  Created by Elsaadany on 05/04/2021.
//

import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet weak var languageTF: PickerTF!
    
    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getVersion()
        setLanguageOptions()
    }
    
    private func setLanguageOptions() {
        let languages = ["Eng", "العربية"]
        languageTF.setInputPickerData(to: languages)
    }
    
    private func getVersion() {
        let dict = Bundle.main.infoDictionary!
        let version = dict["CFBundleShortVersionString"] as! String
        versionLabel.text = version
    }
    
    @IBAction func privacyTapped(_ sender: Any) {
    }
    
    @IBAction func languageTapped(_ sender: Any) {
        languageTF.becomeFirstResponder()
    }
    
    @IBAction func aboutTapped(_ sender: Any) {
    }
}
