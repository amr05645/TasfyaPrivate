//
//  Constants.swift
//  Tasfya
//
//  Created by Elsaadany on 05/04/2021.
//

import UIKit
import LanguageManager_iOS


struct Constants {
    static let images = Images()
    static let titles = Titles()
    static let colors = Colors()
    static let sideMenuTitles = SideMenuTitles()
    static let messages = Messages()
}

struct Images {
    let whiteRadioOn = #imageLiteral(resourceName: "whiteRadioOn")
    let radioOn = #imageLiteral(resourceName: "radioOn")
    let radioOff = #imageLiteral(resourceName: "radioOff")
}

struct Titles {
    var done: String {"Done".localiz()}
    var ok: String {"Ok".localiz()}
    var cancel: String {"Cancel".localiz()}
    var orderID: String {"Order ID".localiz()}
    var orderDate: String {"Order Date".localiz()}
    var orderStatus: String {"Order Status".localiz()}
}

struct Messages {
    var langAlert: String {"Kindly confirm changing current language to Arabic".localiz()}
}

struct Colors {
    let selectionColor = #colorLiteral(red: 0.5099999905, green: 0.5059999824, blue: 0.6549999714, alpha: 1)
    let defaultColor = #colorLiteral(red: 0.07100000232, green: 0.1019999981, blue: 0.3140000105, alpha: 1)
    let placeHolder = #colorLiteral(red: 0.949000001, green: 0.9060000181, blue: 0.9959999919, alpha: 0.5)
}

struct SideMenuTitles {
    var home: String {"Home".localiz()}
    var profile: String {"Profile".localiz()}
    var settings: String {"Settings".localiz()}
    var location: String {"Location".localiz()}
    var language: String {"Language".localiz()}
    var contactUs: String {"Contact Us".localiz()}
    var cart: String {"Cart".localiz()}
    var orders: String {"Orders".localiz()}
    var country: String {"Country".localiz()}
    var login: String {"Login / Sign Up".localiz()}
    var logout: String {"Logout".localiz()}
}
