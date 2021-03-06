//
//  DataModel.swift
//  Tasfya
//
//  Created by Amr on 02/08/2021.
//

import Foundation

// MARK: - Products
struct Categories: Codable {
    var success: String?
    var data: [Datum]?
    var message: String?
    var categories: Int?
}

// MARK: - Datum
struct Datum: Codable {
    var id, image, icon: String?
    var order: String?
    var parentID, name, totalProducts: String?

    enum CodingKeys: String, CodingKey {
        case id, image, icon, order
        case parentID = "parent_id"
        case name
        case totalProducts = "total_products"
    }
}
