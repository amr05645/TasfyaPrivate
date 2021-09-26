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

//set, get & remove User own profile in cache
struct UserProfileCache {
    
    static let key = "userProfileCache"
    
    static func save(_ value: Register?) {
         UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: key)
    }
    
    static func get() -> Register? {
        var userData: Register?
        
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            userData = try? PropertyListDecoder().decode(Register.self, from: data)
            return userData
        }
        return userData
    }
    
    static func remove() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
