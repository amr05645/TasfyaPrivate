//
//  SettingsVC.swift
//  Tasfya
//
//  Created by Elsaadany on 05/04/2021.
//

import UIKit

class SettingsVC: UIViewController {
    
    var selectedLanguage = LanguageHandler.getLanguage()
    
    @IBOutlet weak var languageTF: PickerTF!
    
    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getVersion()
        setLanguageOptions()
        self.languageTF.text = UserDefaults.standard.value(forKey: "lang") as? String
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
        languageTF.changeLanguage = {
            UserDefaults.standard.setValue(self.languageTF.text, forKey: "lang")
            self.showAlert(message: Constants.messages.langAlert) {
                switch self.selectedLanguage {
                case "ar":
                    LanguageHandler.changeLanguage(to: "en")
                case "en":
                    LanguageHandler.changeLanguage(to: "ar")
                default:
                    return
                }
            }
        }
        
    }
    
    @IBAction func aboutTapped(_ sender: Any) {
    }
}
