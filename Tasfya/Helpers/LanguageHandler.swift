//
//  LanguageHandler.swift
//  Tasfya
//
//  Created by Elsaadany on 19/04/2021.
//

import Foundation
import LanguageManager_iOS
import IQKeyboardManagerSwift

struct LanguageHandler {
    
    static func changeLanguage(to language: Languages) {
        
        // change the language
        LanguageManager.shared.setLanguage(language: language)
        { title -> UIViewController in
            return setRootVC(to: HomeScreenVC())
        } animation: { view in
            // do custom animation
            view.transform = CGAffineTransform(scaleX: 2, y: 2)
            view.alpha = 0
        }
        
        UITextField.appearance().textAlignment = language == .ar ? .right : .left
        UITextView.appearance().textAlignment = language == .ar ? .right : .left
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = Constants.titles.done
    }
    
    static func getLanguage() -> Languages {
        return LanguageManager.shared.currentLanguage
    }
}
