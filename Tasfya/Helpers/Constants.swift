//
//  Constants.swift
//  Tasfya
//
//  Created by Elsaadany on 05/04/2021.
//

import UIKit

struct Constants {
    static let images = Images()
    static let titles = Titles()
    static let colors = Colors()
    static let sideMenuTitles = SideMenuTitles()
}

struct Images {
    let whiteRadioOn = #imageLiteral(resourceName: "whiteRadioOn")
    let radioOn = #imageLiteral(resourceName: "radioOn")
    let radioOff = #imageLiteral(resourceName: "radioOff")
}

struct Titles {
    var done: String {"Done"}
    var cancel: String {"Cancel"}
    var orderID: String {"Order ID"}
    var orderDate: String {"Order Date"}
    var orderStatus: String {"Order Status"}
}

struct Colors {
    let selectionColor = #colorLiteral(red: 0.5099999905, green: 0.5059999824, blue: 0.6549999714, alpha: 1)
    let defaultColor = #colorLiteral(red: 0.07100000232, green: 0.1019999981, blue: 0.3140000105, alpha: 1)
    let placeHolder = #colorLiteral(red: 0.949000001, green: 0.9060000181, blue: 0.9959999919, alpha: 0.5)
}

struct SideMenuTitles {
    var home: String {"Home"}
    var profile: String {"Profile"}
    var settings: String {"Settings"}
    var location: String {"Location"}
    var language: String {"Language"}
    var contactUs: String {"Contact Us"}
    var cart: String {"Cart"}
    var orders: String {"Orders"}
    var country: String {"Country"}
}
