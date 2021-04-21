//
//  CurrentUser.swift
//  Tasfya
//
//  Created by Elsaadany on 21/04/2021.
//

import Foundation

struct CurrentUser {
    static var logged: Bool {UserDefaults.standard.bool(forKey: "logged")}
    
    static func login() {
        UserDefaults.standard.setValue(true, forKey: "logged")
    }
    
    static func logout() {
        UserDefaults.standard.removeObject(forKey: "logged")
    }
}
