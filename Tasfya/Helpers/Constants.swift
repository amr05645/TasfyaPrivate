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
}

struct Images {
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
}
