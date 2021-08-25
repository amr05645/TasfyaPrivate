//
//  LanguageHandler.swift
//  Tasfya
//
//  Created by Elsaadany on 19/04/2021.
//

import Foundation
import IQKeyboardManagerSwift
import MOLH

struct LanguageHandler {
    
    static func changeLanguage(to language: String) {
        
        MOLH.setLanguageTo(language)
        
        UIApplication.shared.keyWindow?.rootViewController = setRootVC(to: HomeScreenVC())
        
        UITextField.appearance().textAlignment = language == "ar" ? .right : .left
        UITextView.appearance().textAlignment = language == "ar" ? .right : .left
        UILabel.appearance().textAlignment = language == "ar" ? .right : .left
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = Constants.titles.done
    }
    
    static func getLanguage() -> String {
        return MOLHLanguage.currentAppleLanguage()
    }
}
