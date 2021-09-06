//
//  Constants.swift
//  Tasfya
//
//  Created by Elsaadany on 05/04/2021.
//

import UIKit
import MOLH


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
    var done: String {"Done".localized}
    var ok: String {"Ok".localized}
    var cancel: String {"Cancel".localized}
    var orderID: String {"Order ID".localized}
    var orderDate: String {"Order Date".localized}
    var orderStatus: String {"Order Status".localized}
    var categoris: String {"Categoris".localized}
}

struct Messages {
    var langAlert: String {"Kindly confirm changing current language to Arabic".localized}
    var emptyTF: String {"Please fill required fields!".localized}
}

struct Colors {
    let selectionColor = #colorLiteral(red: 0.5099999905, green: 0.5059999824, blue: 0.6549999714, alpha: 1)
    let defaultColor = #colorLiteral(red: 0.07100000232, green: 0.1019999981, blue: 0.3140000105, alpha: 1)
    let placeHolder = #colorLiteral(red: 0.949000001, green: 0.9060000181, blue: 0.9959999919, alpha: 0.5)
}

struct SideMenuTitles {
    var home: String {"Home".localized}
    var categories: String {"Categories".localized}
    var shop: String {"Shop".localized}
    var myAccount: String {"My Account".localized}
    var myOrders: String {"My Orders".localized}
    var myAddresses: String {"My Addresses".localized}
    var myFavorites: String {"My Favorites".localized}
    var contactUs: String {"Contact Us".localized}
    var about: String {"About".localized}
    var shareApp: String {"Share App".localized}
    var rateApp: String {"Rate App".localized}
    var settings: String {"Settings".localized}
    var login: String {"Login / Sign Up".localized}
    var logout: String {"Logout".localized}
}
