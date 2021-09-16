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
    
    var languageId: Int {
        get {
            if MOLHLanguage.currentAppleLanguage() == "en" {
                return 1
            } else if MOLHLanguage.currentAppleLanguage() == "ar" {
                return 4
            }
            return 1
        }
    }
    
    static func changeLanguage(to language: String) {
        
        MOLH.setLanguageTo(language)
        
        UIApplication.shared.keyWindow?.rootViewController = setRootVC(to: HomeScreenVC())
        
        UITextField.appearance().textAlignment = language == "ar" ? .right : .left
        UITextView.appearance().textAlignment = language == "ar" ? .right : .left
        UILabel.appearance().textAlignment = language == "ar" ? .center : .center
        UISearchBar.appearance().semanticContentAttribute = language == "en" ? .forceLeftToRight : .forceRightToLeft
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = Constants.titles.done
    }
    
    static func getLanguage() -> String {
        return MOLHLanguage.currentAppleLanguage()
    }
}
