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
