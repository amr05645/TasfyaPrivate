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
        UserDefaults.standard.removeObject(forKey: "UID")
    }
    
    static func save(userID: String) {
        UserDefaults.standard.set(userID, forKey: "UID")
    }
    
    static func get() -> String? {
        return UserDefaults.standard.string(forKey: "UID")
    }
    
}
